import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/models/Weather.dart';

class WeatherProvider with ChangeNotifier{
  String apiKey = 'e00929ca7e8b64a6461db9404b3e92a7';

  bool isLoading = false;
  LatLng? currentLocation;
  bool isLocationError = false;

  late Weather weather;

  /*optional param with default value
  * if pass will override default value*/
  Future<void> getWeatherData({bool isRefresh = false}) async {
    isLoading = true;
    await Location().requestService().then(
        (value) async {
          if (value) {
            final locData = await Location().getLocation();
            currentLocation = LatLng(locData.latitude!, locData.longitude!);
            await _getCurrentWeather(currentLocation!);
            await _getDailyWeather(currentLocation!);
          }else {
            isLoading = false;
            isLocationError = true;
            notifyListeners();
          }
        }
    );
  }

  Future<void> _getCurrentWeather(LatLng location) async {
    // TODO: implement _getCurrentWeather
    /*call to api requires
    * double lat, long
    * String appId = apiKey
    * https://home.openweathermap.org/api_keys*/
    Uri url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    }catch(error){
      print(error);
      throw error;
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _getDailyWeather(LatLng location) async {
    // TODO: impement getDailyWeather
  }

  Future<LocationData> getLocation() async {
    LocationData? locData = null;
    await Location().requestService().then(
        (value) async {
          if (!value){
            throw Exception('Cannot get location');
          }
          locData = await Location().getLocation();
        }
    );
    return locData!;
  }
}