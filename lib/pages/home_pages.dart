import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/widgets/forecast_item.dart';
import 'package:weatherapp/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  Future<Position> getLocation() async {
    bool _serviceEnabled;
    LocationPermission _permission;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      return Future.error("Servicios de geolocalización estan deshabilitados");
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error("Los permisos han sido denegados");
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   getLocation().then((value) {
      //     print(value.latitude);
      //     print(value.longitude);
      //   });
      // }),
      backgroundColor: Color(0xff282B30),
      appBar: AppBar(
        title: Text(
          "Weather APP",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff282B30),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.location_on_outlined,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color(0xff6b9dfc),
                  Color(0xff205cf1),
                ],
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                Text(
                  "Lima Peru",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Image.asset(
                  "assets/images/heavycloudy.png",
                  height: 100,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "16.1",
                  style: TextStyle(fontSize: 85, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherItem(
                        value: "6.0", unit: "km/h", imagePath: "windspeed"),
                    WeatherItem(value: "58", unit: "%", imagePath: "humidity"),
                    WeatherItem(value: "100", unit: "%", imagePath: "cloud"),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "Forecast",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                ForecastItem(),
                ForecastItem(),
                ForecastItem(),
                ForecastItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
