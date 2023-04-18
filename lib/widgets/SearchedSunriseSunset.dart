import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/utils/DateAndTime.dart';
import 'package:provider/provider.dart';

class SearchedSunriseSunset extends StatelessWidget {
  const SearchedSunriseSunset({Key? key}) : super(key: key);

  final TextStyle _style1 =
  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  Widget _sunriseSunsetBuilder(
      {required String header, required String body, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 30,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              header,
              style: _style1,
            ),
            Text(
              body,
              style:
              _style1.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    String sunrise = '';
    String sunset = '';
    if (!weatherData.isLoading) {
      sunrise = DateAndTime.unixEpochToTime(weatherData.weatherSearched.sunrise);
      sunset = DateAndTime.unixEpochToTime(weatherData.weatherSearched.sunset);
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10.0),
        child: Consumer<WeatherProvider>(
          builder: (context, weatherData, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _sunriseSunsetBuilder(
                      header: 'Sunrise',
                      body: sunrise,
                      icon: MdiIcons.weatherSunsetUp),
                  const SizedBox(
                    width: 10,
                  ),
                  _sunriseSunsetBuilder(
                      header: 'Sunset',
                      body: sunset,
                      icon: MdiIcons.weatherSunsetDown),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
