import 'package:all_weather_app/Weather_App.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, //removes that watermark from the emulator
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatherApp(),
    );
  }
}

