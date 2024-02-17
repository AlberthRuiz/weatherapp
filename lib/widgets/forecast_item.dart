import 'package:flutter/material.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: Color(0xff3E4145),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: 4,
              offset: Offset(4, 8),
            ),
          ]),
      child: Column(
        children: [
          Text(
            "00:00",
            style: TextStyle(
              color: Colors.white38,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Image.asset(
            "assets/images/overcast.png",
            height: 30,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "5.5 C",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
