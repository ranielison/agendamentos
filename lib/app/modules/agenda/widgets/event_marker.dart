import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class EventMarker extends StatelessWidget {
  final CalendarController calendarController;
  final DateTime date;
  final int amount;
  final bool visible;

  const EventMarker({
    Key key,
    this.calendarController,
    this.date,
    this.amount,
    this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Get.theme.primaryColor,
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '$amount',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
