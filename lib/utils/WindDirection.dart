class WindDirection {
  static String windDirection(int windAngle) {
    const List<String> directions = [
      'North',
      'North East',
      'East',
      'South East',
      'South',
      'South West',
      'West',
      'North West'
    ];
    int index = ((windAngle / 45) + 0.5).floor() % 8;
    return directions[index];
  }

  static double convertWind(double windSpeed){
    return windSpeed/1;
  }
}
