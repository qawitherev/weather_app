import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MapString {
  static Icon mapStringToIcon(
      BuildContext context, String input, double iconSize) {
    IconData? icon;
    switch (input) {
      case 'Thunderstorm':
        icon = MdiIcons.weatherLightningRainy;
        break;
      case 'Drizzle':
        icon = MdiIcons.weatherPartlyRainy;
        break;
      case 'Clouds':
        icon = MdiIcons.weatherCloudy;
        break;
      case 'Mist':
        icon = MdiIcons.weatherFog;
        break;
      case 'fog':
        icon = MdiIcons.weatherFog;
        break;
      case 'Smoke':
        icon = MdiIcons.smoke;
        break;
      case 'Haze':
        icon = MdiIcons.weatherHazy;
        break;
      case 'Dust':
      case 'Sand':
      case 'Ash':
        icon = MdiIcons.weatherDust;
        break;
      case 'Squall':
      case 'Tornado':
        icon = MdiIcons.weatherTornado;
        break;
      default:
        icon = MdiIcons.weatherCloudy;
    }
    return Icon(
      icon,
      size: iconSize,
      color: Theme.of(context).primaryColor,
    );
  }

  static Text mapInputToWeather(BuildContext context, String input) {
    String? text;
    const TextStyle _style =
        TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
    switch (input) {
      case 'Tornado':
        text = 'Tornado';
        break;
      case 'Thunderstorm':
        text = 'Thunderstorm';
        break;
      case 'Drizzle':
        text = 'Drizzly';
        break;
      case 'Rain':
        text = 'Raining';
        break;
      case 'Snow':
        text = 'Snowing';
        break;
      case 'Mist':
        text = 'Misty';
        break;
      case 'fog':
        text = 'Foggy';
        break;
      case 'Smoke':
        text = 'Smoky';
        break;
      case 'Squall':
        text = 'Squally';
        break;
      case 'Haze':
        text = 'Hazy';
        break;
      case 'Dust':
        text = 'Dusty';
        break;
      case 'Sand':
        text = 'Sandy';
        break;
      case 'Ash':
        text = 'Ashy';
        break;
      case 'Clear':
        text = "Sunny";
        break;
      case 'Clouds':
        text = "Cloudy";
        break;
      case 'few clouds':
        text = "Few Clouds";
        break;
      default:
        text = "No Info";
    }
    return Text(
      text,
      style: _style,
    );
  }
}
