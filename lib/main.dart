import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/widgets/Humidity.dart';
import 'package:my_weather_app/widgets/MainWeather.dart';
import 'package:my_weather_app/widgets/SearchBar.dart';
import 'package:my_weather_app/widgets/SunriseSunset.dart';
import 'package:my_weather_app/widgets/Wind.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // set color here
      statusBarBrightness: Brightness.light,));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        debugShowCheckedModeBanner: false,
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
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () => _refreshWeather(context),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              const SliverAppBar(
                title: const Text('My Weather App'),
                floating: false,
                pinned: false,
                foregroundColor: Colors.black,
                backgroundColor: Color.fromRGBO(255, 255, 255, 100),
              ),
              SliverToBoxAdapter(
                child: weatherData.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: const [
                              SearchBar(),
                              MainWeather(),
                              Divider(),
                              SunriseSunset(),
                              Humidity(),
                              Wind(),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ));
  }

  /*this is for refresh -> data is there but maybe is old data,
  * so we want to refresh to get latest data*/
  Future<void> _refreshWeather(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(isRefresh: true);
  }

  /*this is when app opens, weather is null and no data*/
  Future<void> _getData() async {
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData(isRefresh: false);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }
}
