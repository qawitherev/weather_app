import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:provider/provider.dart';

class Humidity extends StatelessWidget {
  const Humidity({Key? key}) : super(key: key);
  final TextStyle _style1 =
  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(MdiIcons.waterPercent, size: 50, color: Colors.blue,),
                const VerticalDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Humidity', style: _style1,),
                    Text('${weatherData.weather.humidity}', style: _style1.copyWith(fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
