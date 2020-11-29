import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController
    with SingleGetTickerProviderMixin {
  Map<DateTime, List<dynamic>> events = {};

  RxList _selectedEvents = [].obs;
  List get selectedEvents => _selectedEvents.toList();

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

  void onDaySelected(
    DateTime day,
    List events,
    List holidays,
  ) {
    print('CALLBACK: _onDaySelected');

    _selectedDay.value = day;
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
