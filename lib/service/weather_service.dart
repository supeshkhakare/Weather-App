import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Models/weather_model.dart';

class WeatherService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String? apiKey;

  // constructor ask for apiKey
  WeatherService({this.apiKey});

  // getting weather data from API
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse("$baseUrl?q=$cityName&appid=$apiKey&units=metric"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body.toString()));
    } else {
      throw Exception("Failed to Fetch Weather");
    }
  }

  // current your city Location Function

  Future<String> getCurrentCity() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permission permanently denied.");
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String? city = placeMarks[0].locality;
      return city ?? "";
    } catch (e) {
      throw Exception('Error fetching city: $e');
    }
  }
}
