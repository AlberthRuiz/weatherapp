import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/forecast_model.dart';
import 'package:weatherapp/models/weather_model.dart';

class ApiServices {
  Future<WeatherModel> getWeatherInfo(double lat, double lang) async {
    Uri url = Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=72b638b074be4c9faa912318241702&q=$lat,$lang&aqi=no");
    http.Response response = await http.get(url);
    Map<String, dynamic> data = json.decode(response.body);
    WeatherModel weatherModel = WeatherModel.fromJson(data);
    print(weatherModel.location.name);
    return weatherModel;
  }

  Future<ForecastModel?> getForecastInfo(double lat, double lang) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=72b638b074be4c9faa912318241702&q=$lat,$lang&days=1&aqi=no&alerts=no");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }
}
