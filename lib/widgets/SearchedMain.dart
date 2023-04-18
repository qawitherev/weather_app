import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/utils/MapString.dart';
import 'package:provider/provider.dart';

class SearchedMain extends StatelessWidget {
  const SearchedMain({Key? key}) : super(key: key);

  final TextStyle _style1 = const TextStyle(fontSize: 45, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    /*provider = use when data read doesn't change ui always, like this weather app, api call then data is changed
    * consumer = use when ui heavily dependant on ui*/
    final weatherData = Provider.of<WeatherProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MapString.mapStringToIcon(
                context, weatherData.weatherSearched.main, 55),
            Text('${weatherData.weatherSearched.temp.toStringAsFixed(1)}°C', style: _style1,),
          ],
        ),
        Row(),
        Text('thisa text'),
      ],
    );
  }
}
