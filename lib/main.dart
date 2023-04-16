import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/utils/DateAndTime.dart';
import 'package:my_weather_app/utils/MapString.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextStyle _style1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final TextStyle _style2 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Weather App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_outlined),
                  Text(
                    weatherData.weather.name,
                    style: _style1,
                  ),
                ],
              ),
              Text(DateAndTime.unixEpochToDate(weatherData.weather.dt)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MapString.mapStringToIcon(
                      context, weatherData.weather.main, 55),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '${weatherData.weather.temp.toStringAsFixed(1)}°C',
                    style: _style1.copyWith(fontSize: 45),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${weatherData.weather.tempMin.toStringAsFixed(1)}°/${weatherData.weather.tempMax.toStringAsFixed(1)}°',
                    style: _style2.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                      'Feels like ${weatherData.weather.feelsLike.toStringAsFixed(1)}°C'),
                ],
              ),
              const SizedBox(height: 3),
              MapString.mapInputToWeather(
                  context, weatherData.weather.description),
            ],
          ),
        ));
  }

  Future<void> _refreshWeather(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentWeather();
  }

  @override
  void initState() {
    super.initState();
    _refreshWeather(context);
  }
}
