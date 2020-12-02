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

  ExpedienteDay temp;
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
      if (events.containsKey(ag.startDate)) {
        events[ag.startDate].add(ag);
      } else {
        events[ag.startDate] = [ag];
      }
    });

    //Vou ter que puxar no inicio, a lista de todos os dias de expediente, e pra cada dia
    //que contenha evento fazer os calculos de disponibilidade com base nos horarios disponiveis

    ExpedienteDay atual = ExpedienteDay(
      inicio: [8, 0],
      //pausa: DateTime(2020, 1, 1, 12),
      //retorno: DateTime(2020, 1, 1, 14),
      fim: [12, 0],
    );

    events.forEach(
      (key, value) {
        DateTime data = DateTime(key.year, key.month, key.day);
        temp = atual;

        DateTime inicio = data.add(Duration(
          hours: temp.inicio[0],
          minutes: temp.inicio[1],
        ));

        DateTime fim = data.add(Duration(
          hours: temp.fim[0],
          minutes: temp.fim[1],
        ));

        if (temp.pausa != null) {
          tempPausa = data.add(Duration(
            hours: temp.pausa[0],
            minutes: temp.pausa[1],
          ));

          retorno = data.add(Duration(
            hours: temp.retorno[0],
            minutes: temp.retorno[1],
          ));
        }

        tempDate = inicio;

        for (Agendamento ag in value) {
          if (tempDate.compareTo(ag.startDate) < 0) {
            disponibilidade[Constants.dformat.format(data)] = true;
            refresh();
            break;
          } else {
            tempDate = ag.startDate.add(ag.duration);
            if (tempPausa != null) {
              if (tempDate.compareTo(inicio) >= 0) {
                tempDate = retorno;
                tempPausa = null;
              }
            }
            if (tempDate.compareTo(fim) >= 0) {
              disponibilidade[Constants.dformat.format(data)] = false;
              refresh();
              break;
            }
          }
        }

        if (tempDate.compareTo(fim) < 0) {
          disponibilidade[Constants.dformat.format(data)] = true;
          refresh();
        }
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
