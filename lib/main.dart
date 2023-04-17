import 'package:flutter/material.dart';
import 'package:my_weather_app/provider/WeatherProvider.dart';
import 'package:my_weather_app/widgets/MainWeather.dart';
import 'package:my_weather_app/widgets/SunriseSunset.dart';
import 'package:provider/provider.dart';

void main() {
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshWeather(context),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverAppBar(
              title: Text('My Weather App'),
              floating: false,
              pinned: false,
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: const [MainWeather(), SunriseSunset()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*this is for refresh -> data is there but maybe is old data,
  * so we want to refresh to get latest data*/
  Future<void> _refreshWeather(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentWeather();
    print('weather refreshed');
  }

  /*this is when app opens, weather is null and no data*/
  Future<void> _getData() async {
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getCurrentWeather();
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }
}
