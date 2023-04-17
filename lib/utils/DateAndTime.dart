import 'package:intl/intl.dart';


class DateAndTime{
  static String unixEpochToDate(int unix){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: true);
    return DateFormat.yMMMEd().format(dateTime);
  }

  static String unixEpochToTime(int unix){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: false);
    //will return e.g. 1.30 PM
    return DateFormat.jm().format(dateTime);
  }
}