import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<String> weekDays = [
  'SEG',
  'TER',
  'QUA',
  'QUI',
  'SEX',
  'SAB',
  'DOM',
];

class SettingsController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();
  RxList<TimeOfDay> inicioHorarios = <TimeOfDay>[
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
  ].obs;

  RxList<TimeOfDay> fimHorarios = <TimeOfDay>[
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
  ].obs;

  RxList<TimeOfDay> pausaHorarios = <TimeOfDay>[
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
  ].obs;

  RxList<TimeOfDay> retornoHorarios = <TimeOfDay>[
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
  ].obs;

  setHorarioInicio(index, horario) {
    inicioHorarios[index] = horario;
    refresh();
  }

  setHorarioFim(index, horario) {
    fimHorarios[index] = horario;
    refresh();
  }

  setHorarioPausa(index, horario) {
    pausaHorarios[index] = horario;
    refresh();
  }

  setHorarioRetorno(index, horario) {
    retornoHorarios[index] = horario;
    refresh();
  }

  void limparDados() {
    _localDataHelper.limpaGeral();
  }
}
