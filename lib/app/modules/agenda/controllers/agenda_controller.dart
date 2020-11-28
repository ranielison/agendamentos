import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as eventos;
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController
    with SingleGetTickerProviderMixin {
  Map<DateTime, List<dynamic>> events = {};

  RxList _selectedEvents = [].obs;
  List get selectedEvents => _selectedEvents.toList();

  List<Meeting> meetings;

  Rx<DateTime> _selectedDay = DateTime.now().obs;
  DateTime get selectedDay => _selectedDay.value;

  AnimationController animationController;
  CalendarController calendarController;

  List<Agendamento> agendamentos;

  final Map<DateTime, List> holidays = {
    DateTime(2020, 1, 1): ['New Year\'s Day'],
    DateTime(2020, 1, 6): ['Epiphany'],
    DateTime(2020, 2, 14): ['Valentine\'s Day'],
    DateTime(2020, 4, 21): ['Easter Sunday'],
    DateTime(2020, 12, 25): ['Easter Monday'],
  };

  @override
  void onInit() {
    super.onInit();
    agendamentos = agendamentosMock;
    agendamentos.forEach((ag) {
      if (events.containsKey(ag.startDate)) {
        events[ag.startDate].add(ag);
      } else {
        events[ag.startDate] = [ag];
      }
    });

    _selectedEvents.clear();
    _selectedEvents.addAll(events[_selectedDay] ?? []);
    calendarController = CalendarController();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationController.forward();
  }

  List<Meeting> getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting(
        'Conference',
        DateTime(today.year, today.month, today.day, 9, 0, 0),
        DateTime(today.year, today.month, today.day, 11, 0, 0),
        Colors.red,
        false,
      ),
    );
    return meetings;
  }

  void onDaySelected(
    DateTime day,
    List events,
    List holidays,
  ) {
    print('CALLBACK: _onDaySelected');

    _selectedEvents.clear();
    _selectedEvents.addAll(events);
  }

  void onVisibleDaysChanged(
    DateTime first,
    DateTime last,
    CalendarFormat format,
  ) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void onCalendarCreated(
    DateTime first,
    DateTime last,
    CalendarFormat format,
  ) {
    print('CALLBACK: _onCalendarCreated');
  }
}

class MeetingDataSource extends eventos.CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
