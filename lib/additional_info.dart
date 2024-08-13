// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class additional_information extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const additional_information({
    super.key,
    required this.icon,
    required this.label,
    required this.value
  });


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(icon,size: 32,),
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 10),
        Text(
          value ,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
