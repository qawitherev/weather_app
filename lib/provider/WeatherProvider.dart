import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/models/WeatherTest.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = 'e00929ca7e8b64a6461db9404b3e92a7';

  bool _isLoading = false;
  LatLng? currentLocation;
  bool isLocationError = false;

  late WeatherTest weather;
  late WeatherTest weatherSearched;

  bool get isLoading => _isLoading;

  //test purpose
  double lat = 3.0761084;
  double long = 101.5896045;

  /*optional param with default value
  * if pass will override default value*/
  Future<void> getWeatherData({bool isRefresh = false}) async {
    _isLoading = true;
    await Location().requestService().then((value) async {
      if (value) {
        final locData = await Location().getLocation();
        currentLocation = LatLng(locData.latitude!, locData.longitude!);
        await getCurrentWeather(currentLocation!);
        // await _getDailyWeather(currentLocation!);
      } else {
        _isLoading = false;
        isLocationError = true;
        notifyListeners();
      }
    });
  }

  Future<void> getCurrentWeather(LatLng location) async {
    _isLoading = true;
    notifyListeners();
    // TODO: initial=>accept location
    // TODO: implement _getCurrentWeather
    /*call to api requires
    * double lat, long
    * String appId = apiKey
    * https://home.openweathermap.org/api_keys*/
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location
            .latitude}&lon=${location
            .longitude}&exclude=minutely&units=metric&appid=$apiKey');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      weather = WeatherTest.fromJson(extractedData);
    } catch (error) {
      print(error);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _getDailyWeather(LatLng location) async {
    // TODO: implement getDailyWeather
  }

  Future<LocationData> getLocation() async {
    LocationData? locData = null;
    await Location().requestService().then((value) async {
      if (!value) {
        throw Exception('Cannot get location');
      }
      locData = await Location().getLocation();
    });
    return locData!;
  }

  Future<void> searchWithLocation({required String location}) async {
    _isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey',);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weatherSearched = WeatherTest.fromJson(extractedData);
      print(extractedData);
    }catch (error) {
      print(error);
    }finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
