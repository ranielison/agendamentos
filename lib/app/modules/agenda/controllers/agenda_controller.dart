import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController
    with SingleGetTickerProviderMixin {
  Map<DateTime, List<dynamic>> events = {};
  Map<DateTime, bool> disponibilidade = {};

  ExpedienteDay temp;
  DateTime tempDate;
  DateTime tempPausa;

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
      aberto: true,
      inicio: DateTime(2020, 1, 1, 8),
      pausa: DateTime(2020, 1, 1, 12),
      retorno: DateTime(2020, 1, 1, 14),
      fim: DateTime(2020, 1, 1, 18),
    );

    events.forEach(
      (key, value) {
        temp = atual;
        tempDate = atual.inicio;
        tempPausa = atual.pausa;
        for (Agendamento ag in value) {
          if (tempDate.compareTo(ag.startDate) < 0) {
            disponibilidade[key] = true;
            break;
          } else {
            tempDate = ag.startDate.add(ag.duration);
            if (tempPausa != null) {
              if (tempDate.compareTo(temp.inicio) >= 0) {
                tempDate = temp.retorno;
                tempPausa = null;
              }

              if (tempDate.compareTo(temp.fim) >= 0) {
                disponibilidade[key] = false;
                break;
              }
            }
          }
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
