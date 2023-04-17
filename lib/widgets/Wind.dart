import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/utils/WindDirection.dart';
import 'package:provider/provider.dart';

class Wind extends StatelessWidget {
  const Wind({Key? key}) : super(key: key);

  final TextStyle _style1 =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.normal);

  Widget _columnBuilder(
      {required IconData icon, required String header, required String data}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 40,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          header,
          style: _style1,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          data,
          style: _style1.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _columnBuilder(
                  icon: MdiIcons.weatherWindy,
                  header: 'Wind Speed',
                  data: '${weatherData.weather.windSpeed.toStringAsFixed(2)} m/s'),
              const SizedBox(
                width: 20,
              ),
              _columnBuilder(
                  icon: MdiIcons.sunCompass,
                  header: 'Wind Direction',
                  data: WindDirection.windDirection(weatherData.weather.windAngle))
            ],
          ),
        ),
      ),
    );
  }
}
