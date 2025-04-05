import 'package:flutter/material.dart';

class DateFormatUtil {

  static String formatDateTime(DateTime? dt) {
    if (dt == null) return "";
    return '${dt.year.toString().padLeft(4, '0')}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  static void pickDateTime(
      BuildContext context,
      Function(DateTime picked) callback,
      {String? label, String? selectedDateTime}){
    DateTime? dateTime;
    TimeOfDay? timeOfDay;
    if (selectedDateTime != null && selectedDateTime.isNotEmpty){
      dateTime = DateTime.parse(selectedDateTime);
      timeOfDay = TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      );
    }
    pickDate(
      context: context,
      label: label,
      selectedDate: dateTime,
      callback: (pickedDate) {
        if (pickedDate != null){
          pickTime(
            context: context,
            label: label,
            timeOfDay: timeOfDay,
            callback: (pickedTime) {
              if (pickedTime != null){
                DateTime selectedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                callback(selectedDateTime);
              }
            },
          );
        }
      },
    );
  }

  static Future<void> pickDate({
    required BuildContext context,
    required Function(DateTime? selectedDateTime) callback,
    String? label,
    DateTime? selectedDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: label,
    );
    callback(picked);
  }

  static Future<void> pickTime({
    required BuildContext context,
    required Function(TimeOfDay? selectedTimeOfDay) callback,
    String? label,
    TimeOfDay? timeOfDay,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay ?? TimeOfDay.now(),
      helpText: label,
    );
    callback(picked);
  }

  static double getDaysBetween(DateTime from, DateTime to, {bool inclusive = false}) {
    // Ensure from is before to
    if (from.isAfter(to)) {
      final temp = from;
      from = to;
      to = temp;
    }
    final difference = (to.difference(from).inSeconds / (24 * 60 * 60));
    return inclusive ? difference + 1 : difference;
  }

  static String fromMillisecondsToString(int millisecondsSinceEpoch){
    if (millisecondsSinceEpoch == 0) return "";
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final data = formatDateTime(dateTime).split(" ")[0].split("-");
    String month = "";
    switch(data[1]){
      case '01':
        month = "J";
        break;
      case '02':
        month = "F";
        break;
      case '03':
        month = "M";
        break;
      case '04':
        month = "A";
        break;
      case '05':
        month = "M";
        break;
      case '06':
        month = "J";
        break;
      case '07':
        month = "J";
        break;
      case '08':
        month = "A";
        break;
      case '09':
        month = "S";
        break;
      case '10':
        month = "O";
        break;
      case '11':
        month = "N";
        break;
      case '12':
        month = "D";
        break;
      default:
        break;
    }
    return " $month${data[0].substring(2,4)}";
  }
}