import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/widgets/Humidity.dart';
import 'package:my_weather_app/widgets/SearchedMain.dart';
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
    return weatherData.isLoading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
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
                    children: const [SearchedMain()],
                  ),
                )
              ],
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
