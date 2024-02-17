import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherItem extends StatelessWidget {
  String value;
  String unit;
  String imagePath;

  WeatherItem(
      {required this.value, required this.unit, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/${this.imagePath}.png",
          height: 50,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "${this.value} ${this.unit}",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}
