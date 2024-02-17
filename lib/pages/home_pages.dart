import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/forecast_model.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/widgets/forecast_item.dart';
import 'package:weatherapp/widgets/weather_item.dart';
import 'package:weatherapp/services/api_services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ForecastModel? _forecastModel;

  Future<void> getDataLocation() async {
    Position position = await getLocation();
    _forecastModel = await ApiServices()
        .getForecastInfo(position.latitude, position.longitude);
    setState(() {});
  }

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
  void initState() {
    getDataLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {

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
      body: _forecastModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                        "${_forecastModel?.location.name}, ${_forecastModel?.location.country}",
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
                        "${_forecastModel!.current.tempC.toString()} °",
                        style: TextStyle(fontSize: 85, color: Colors.white),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherItem(
                              value: _forecastModel!.current.windKph.toString(),
                              unit: "km/h",
                              imagePath: "windspeed"),
                          WeatherItem(
                              value:
                                  _forecastModel!.current.humidity.toString(),
                              unit: "%",
                              imagePath: "humidity"),
                          WeatherItem(
                              value: _forecastModel!.current.cloud.toString(),
                              unit: "%",
                              imagePath: "cloud"),
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
                    children: List.generate(
                        _forecastModel!.forecast.forecastday[0].hour.length,
                        (index) => ForecastItem(
                            time: _forecastModel!
                                .forecast.forecastday[0].hour[index].time
                                .toString(),
                            value: _forecastModel!
                                .forecast.forecastday[0].hour[index].tempC
                                .toString(),
                            isDay: _forecastModel!
                                .forecast.forecastday[0].hour[index].isDay)),
                  ),
                ),
              ],
            ),
    );
  }
}
