class WeatherTest {
  final double temp;
  final double tempMin;
  final double tempMax;
  final String main;
  final String description;
  final int sunrise;
  final int sunset;
  final String name;
  final int dt;
  final double feelsLike;

  WeatherTest({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.main,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.name,
    required this.dt,
    required this.feelsLike,
  });

  factory WeatherTest.fromJson(Map<String, dynamic> json) {
    return WeatherTest(
      temp: (json['main']['temp']).toDouble(),
      tempMin: (json['main']['temp_min']).toDouble(),
      tempMax: (json['main']['temp_max']).toDouble(),
      main: (json['weather'][0]['main']).toString(),
      description: (json['weather'][0]['description']).toString(),
      sunrise: (json['sys']['sunrise']).toInt(),
      sunset: (json['sys']['sunset']).toInt(),
      name: (json['name']).toString(),
      dt: (json['dt']).toInt(),
      feelsLike: (json['main']['feels_like']),
    );
  }
}
