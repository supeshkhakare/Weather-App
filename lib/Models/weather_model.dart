class WeatherModel {
  // define parameters
  final String? cityname;
  final double? temperature;
  final String? mainCondition;

  // constructor
  WeatherModel({
    required this.cityname,
    required this.temperature,
    required this.mainCondition,
  });
  // factory is like a constructor but returns value.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        cityname: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}
