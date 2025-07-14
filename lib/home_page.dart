import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // WeatherService instance with API key
  final WeatherService weatherService = WeatherService(
    apiKey: "5c54e8f8906e45d34c4d3e13f4a2146a",
  );

  WeatherModel? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      String cityName = await weatherService.getCurrentCity();
      WeatherModel weatherData = await weatherService.getWeather(cityName);

      setState(() {
        _weather = weatherData;
      });
    } catch (e) {
      debugPrint("EError: $e");
    }
  }

  getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return null;
    }
    switch (mainCondition.toLowerCase()) {
      // Thunderstrom Animation
      case "thunderstorm":
        return 'Assets/Lottie/thunderstrom.json';
      // Rain Animation
      case "rain":
        return 'Assets/Lottie/thunderstrom.json';
      // cloud Animation
      case "clouds":
        return 'Assets/Lottie/clouds.json';
      // Sunny Animation
      case "clear":
        return 'Assets/Lottie/sunny.json';
      // Cloud Animation
      case "drizzle":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
      case "sand":
      case "tornado":
        return 'Assets/Lottie/clouds.json';
      default:
        return 'Assets/Lottie/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: _weather == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weather!.cityname.toString(),
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Lottie.asset(
                      getWeatherAnimation(_weather!.mainCondition.toString())),
                  SizedBox(height: 16),
                  Text(
                    "${_weather?.temperature?.round()} °C",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _weather!.mainCondition.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                ],
              ),
      ),
    );
  }
}
