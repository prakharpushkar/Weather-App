// ignore: file_names
import "package:flutter/material.dart";

class Weather_forecast extends StatelessWidget {
  final String time;
  final String text;
  final IconData icon;
  const Weather_forecast({
    super.key,
    required this.text,
    required this.time,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        child: Container(
          // padding can be used inside container
          width: 100,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child:  Column(
            children: [
              // first widget
              Text(
                time,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              //2 widget
               Icon(
                icon,
                size: 35,
              ),
              const SizedBox(height: 10),
              //3 widget
              Text(
                text,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ));
  }
}
