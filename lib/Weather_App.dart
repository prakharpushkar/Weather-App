// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'ScrollAbleWidget.dart';
import 'additional_info.dart';
import 'secreatApiKey.dart'; // Make sure this file contains the 'openAPIKey' variable

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Future CurrentWeather() async {
    try {
      String name = "London";
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$name,uk&APPID=$openAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw "An unexpected error occurred";
      }
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  CurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        // very useful thing if we want to make print dynamic items.
        future: CurrentWeather(), // thing which is future of the code.
        builder: (context, snapshot) {
          // snapshot is a class that allows u to handle loading state, error state, data state.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator
                    .adaptive()); // here adaptive will autom. give the loading sign based on the OS. for IOS it gives IOS wala loading and for Android it gives Android wala loading
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data;

          final weatherdata = data['list'][0];
          //      data['list'][0]['main']['temp'];

          final currentTempe = weatherdata['main']['temp'];
          final currentSky = weatherdata['weather'][0]['main'];
          final pressure = weatherdata['main']['pressure'];
          final wind = weatherdata['wind']['speed'];
          final humidity = weatherdata['main']['humidity'];

          return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                // by default its vertical scroll view
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "$currentTempe K",
                                      style: const TextStyle(
                                        fontSize: 52,
                                        color:
                                            Color.fromARGB(255, 245, 245, 244),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  if (currentSky == 'Clouds')
                                    const Icon(Icons.cloud, size: 55),
                                  const SizedBox(height: 20),
                                  Text(
                                    " $currentSky",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Hourly Forecast",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 9),
                      
                      // plz refer to readThis file before reading further.
                    
                    SizedBox(
                      height:
                          110, // Define a suitable height for the ListView.builder
                      child: ListView.builder(
                        // this will ensure as we scroll horizontally, items are made simult. This will help in reducing the load on our app.
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          final hourlyforcast = data['list'][index + 1];
                          final currtime = DateTime.parse(hourlyforcast['dt_txt'].toString());
                          return Weather_forecast(
                            time: DateFormat.Hm().format(currtime),
                            icon: hourlyforcast['weather'][0]['main'] ==
                                    'Clouds'
                                ? Icons.cloud
                                : data['list'][index]['weather'][0]['main'] ==
                                        'Rain'
                                    ? Icons.cloud_queue
                                    : Icons.wb_sunny,
                            text:
                                "${hourlyforcast['main']['temp'].toString()} K",
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        additional_information(
                          icon: Icons.water_drop,
                          label: "humidity",
                          value: humidity.toString(),
                        ),
                        additional_information(
                          icon: Icons.air,
                          label: "Wind Speed",
                          value: wind.toString(),
                        ),
                        additional_information(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value: pressure.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
