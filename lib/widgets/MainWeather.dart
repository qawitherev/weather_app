import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/WeatherProvider.dart';
import '../utils/DateAndTime.dart';
import '../utils/MapString.dart';

class MainWeather extends StatelessWidget {
  const MainWeather({Key? key}) : super(key: key);

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
    return Consumer<WeatherProvider>(builder: (context, weatherData, _) {
      return weatherData.isLoading ? const Center(child: CircularProgressIndicator()) : Padding(
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
      );
    },);
  }
}