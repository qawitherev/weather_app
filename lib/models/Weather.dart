import 'package:flutter/cupertino.dart';

class Weather with ChangeNotifier {
  /*temp - tempMax - tempMin - lat - long - feelsLike - pressure - desc
  *  - currently - humidity windSpeed - cityName
  * inside has a singleton constructor that process the json fetched from api*/

  final double temp;
  final double tempMax;
  final double tempMin;
  final double lat;
  final double long;
  final double feelsLike;
  final int pressure;
  final String desc;
  final String currently;
  final int humidity;
  final double windSpeed;
  final String cityname;

  Weather({required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.lat,
    required this.long,
    required this.feelsLike,
    required this.pressure,
    required this.desc,
    required this.currently,
    required this.humidity,
    required this.windSpeed,
    required this.cityname});

  //singleton constructor
  factory Weather.fromJson(Map<String, dynamic> json) {
    /*map of string -> dynamic type, this param is called json*/
    return Weather(
        temp: (json['main']['temp']).toDouble(),
        tempMax: (json['main']['temp_max']).toDouble(),
        tempMin: (json['main']['temp_min']).toDouble(),
        lat: json['coord']['lat'],
        long: json['coord']['long'],
        feelsLike: (json['main']['feels_like']).toDouble(),
        pressure: json['main']['pressure'],
        desc: json['weather'][0]['description'],
        currently: json['weather']['main'],
        humidity: json['main']['humidity'],
        windSpeed:(json['wind']['speed']).toDouble(),
        cityname: json['name']);
  }
}
