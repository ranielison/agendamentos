import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart' as mock;
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController
    with SingleGetTickerProviderMixin {
  final _localDataHelper = Get.find<LocalDataHelper>();

  RxMap<DateTime, List<dynamic>> _events = <DateTime, List<dynamic>>{}.obs;
  Map<DateTime, List<dynamic>> get events => _events;

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
  ExpedienteSettings allExpedientes;

  @override
  void onInit() {
    super.onInit();
    _checkDataBase();
    initListAgendamentos();
  }

  void _checkDataBase() {
    ExpedienteSettings exps = _localDataHelper.loadExpedienteSettings();

    if (exps == null) {
      exps = mock.allExpedientes;
      _localDataHelper.saveExpedienteSettings(exps);
    }
  }

  _initData() {
    agendamentos = _localDataHelper.getAgendamentos();
    allExpedientes = _localDataHelper.loadExpedienteSettings();
    _selectedEvents.clear();
    _disponibilidade.clear();
    _events.clear();
  }

  void initListAgendamentos() {
    _initData();

    agendamentos.forEach((ag) {
      DateTime agDay = DateTime(
        ag.startDate.year,
        ag.startDate.month,
        ag.startDate.day,
      );

      if (_events.containsKey(agDay)) {
        _events[agDay].add(ag);
      } else {
        _events[agDay] = [ag];
      }
    });

    _events.forEach(
      (key, value) {
        bool disponivel = false;
        DateTime data = DateTime(key.year, key.month, key.day);
        ExpedienteDay temp = allExpedientes.expedientes[key.weekday - 1];

        Duration expedientDuration;

        if (temp.pausa[0] != -1) {
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

        int expedientDurationInMinutes = expedientDuration.inMinutes;

        value.forEach(
          (ag) {
            expedientDurationInMinutes -= ag.durationInMinutes;
          },
        );

        if (expedientDurationInMinutes > 0) {
          disponivel = true;
        }

        disponibilidade[Constants.dformat.format(data)] = disponivel;
      },
    );

    DateTime key = DateTime(
      _selectedDay.value.year,
      _selectedDay.value.month,
      _selectedDay.value.day,
    );

    _selectedEvents.clear();
    _selectedEvents.addAll(_events[key] ?? []);
    calendarController = CalendarController();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationController.forward();
    refresh();
  }

  bool dayIsOpen(DateTime day) {
    int weekDay = day.weekday;
    return allExpedientes.expedientes[weekDay - 1].aberto;
  }

  void removeEventFromSelectedEvents(String id) {
    DateTime key = DateTime(
      _selectedDay.value.year,
      _selectedDay.value.month,
      _selectedDay.value.day,
    );

    _selectedEvents.removeWhere((element) => element.idAgendamento == id);
    _events[key].removeWhere(
      (element) => element.idAgendamento == id,
    );
    update();
  }

  void addEventToSelectedEvents(Agendamento ag) {
    DateTime key = DateTime(
      _selectedDay.value.year,
      _selectedDay.value.month,
      _selectedDay.value.day,
    );

    _selectedEvents.add(ag);
    if (_events[key] != null) {
      _events[key] = [..._events[key], ag];
    } else {
      _events.putIfAbsent(key, () => [ag]);
      update();
    }
  }

  void updateEventOnSelectedEvents(Agendamento ag) {
    int index;
    DateTime key = DateTime(
      _selectedDay.value.year,
      _selectedDay.value.month,
      _selectedDay.value.day,
    );

    index = _selectedEvents.indexWhere(
      (element) => element.idAgendamento == ag.idAgendamento,
    );

    if (index >= 0) {
      _selectedEvents[index] = ag;
    }

    index = _events[key].indexWhere(
      (element) => element.idAgendamento == ag.idAgendamento,
    );

    if (index >= 0) {
      _events[key][index] = ag;
    }
    //update();
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
