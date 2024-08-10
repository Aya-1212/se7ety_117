import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeServices {
  static dateFormatter(Timestamp date) {
    String formattedDate = DateFormat("dd-MM-yyyy")
        .format(DateTime.parse(date.toDate().toString()));
    return formattedDate;
  }

  static timeFormatter(Timestamp date) {
    String formattedTime =
        DateFormat("hh:mm").format(DateTime.parse(date.toDate().toString()));
    return formattedTime;
  }

  static isToday(Timestamp date) {
    var diff = DateTime.now()
        .difference(DateTime.parse(date.toDate().toString()))
        .inDays;
    if (diff > 0) {
      return true;
    }
    return false;
  }

  static checkDiff(Timestamp date) {
    var diff = DateTime.now()
        .difference(DateTime.parse(date.toDate().toString()))
        .inHours;
    if (diff > 2) {
      return true;
    }
    return false;
  }
}
