import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController
    with SingleGetTickerProviderMixin {
  Map<DateTime, List<dynamic>> events = {};

  RxMap<String, bool> _disponibilidade = <String, bool>{}.obs;
  Map<String, bool> get disponibilidade => _disponibilidade;

  DateTime tempDate;
  DateTime tempPausa;
  DateTime retorno;

  RxList _selectedEvents = [].obs;
  List get selectedEvents => _selectedEvents.toList();

  Rx<DateTime> _selectedDay = DateTime.now().obs;
  DateTime get selectedDay => _selectedDay.value;

  AnimationController animationController;
  CalendarController calendarController;

  List<Agendamento> agendamentos;

  @override
  void onInit() {
    super.onInit();
    _initListAgendamentos();
  }

  void _initListAgendamentos() {
    agendamentos = agendamentosMock;

    agendamentos.forEach((ag) {
      DateTime agDay = DateTime(
        ag.startDate.year,
        ag.startDate.month,
        ag.startDate.day,
      );

      if (events.containsKey(agDay)) {
        events[agDay].add(ag);
      } else {
        events[agDay] = [ag];
      }
    });

    events.forEach(
      (key, value) {
        bool disponivel = false;
        DateTime data = DateTime(key.year, key.month, key.day);
        ExpedienteDay temp = allExpedientes.expedientes[key.weekday - 1];

        Duration expedientDuration;

        if (temp.pausa != null) {
          expedientDuration =
              Duration(hours: temp.pausa[0], minutes: temp.pausa[1]) -
                  Duration(hours: temp.inicio[0], minutes: temp.inicio[1]) +
                  Duration(hours: temp.fim[0], minutes: temp.fim[1]) -
                  Duration(hours: temp.retorno[0], minutes: temp.retorno[1]);
        } else {
          expedientDuration =
              Duration(hours: temp.fim[0], minutes: temp.fim[1]) -
                  Duration(hours: temp.inicio[0], minutes: temp.inicio[1]);
        }

        value.forEach(
          (ag) {
            expedientDuration -= ag.duration;
          },
        );

        if (expedientDuration.compareTo(Duration()) > 0) {
          disponivel = true;
        }

        disponibilidade[Constants.dformat.format(data)] = disponivel;
      },
    );

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
