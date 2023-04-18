import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/widgets/SearchedHumidity.dart';
import 'package:my_weather_app/widgets/SearchedMain.dart';
import 'package:my_weather_app/widgets/SearchedSunriseSunset.dart';
import 'package:my_weather_app/widgets/SearchedWind.dart';
import 'package:provider/provider.dart';

class LocationSearchedScreen extends StatefulWidget {
  final String location;

  const LocationSearchedScreen({Key? key, required this.location})
      : super(key: key);

  @override
  State<LocationSearchedScreen> createState() => _LocationSearchedScreenState();
}

class _LocationSearchedScreenState extends State<LocationSearchedScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context, listen: true);
    return weatherData.isLoading || weatherData.isLocationMissing
        ? Scaffold(
            appBar: AppBar(backgroundColor: Colors.white, elevation: 0, foregroundColor: Colors.black,),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                     SizedBox(
                      height: 10,
                    ),
                     Text(
                        'If taking too long, entered location may not exist', textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: Text(widget.location),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(MdiIcons.settingsHelper)),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: const [
                        SearchedMain(),
                        Divider(),
                        SearchedSunriseSunset(),
                        SearchedHumidity(),
                        SearchedWind(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    _getData(widget.location);
  }

  Future<void> _getData(String location) async {
    Provider.of<WeatherProvider>(context, listen: false)
        .searchWithLocation(location: location);
  }
}
