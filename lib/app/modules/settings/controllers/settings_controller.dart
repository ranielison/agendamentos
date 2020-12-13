import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  RxBool _needSave = false.obs;
  bool get needSave => _needSave.value;
  setNeedSave(bool value) => _needSave.value = value;

  RxInt intervalSelected = 15.obs;
  RxList<bool> _activeDays = <bool>[].obs;
  List<bool> get activeDays => _activeDays.toList();

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
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
  ].obs;

  RxList<TimeOfDay> pausaHorarios = <TimeOfDay>[
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
  ].obs;

  RxList<TimeOfDay> retornoHorarios = <TimeOfDay>[
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
  ].obs;

  @override
  onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    ExpedienteSettings settings = _localDataHelper.loadExpedienteSettings();

    if (settings != null) {
      for (int i = 0; i < 7; i++) {
        inicioHorarios[i] = TimeOfDay(
          hour: settings.expedientes[i].inicio[0],
          minute: settings.expedientes[i].inicio[1],
        );

        fimHorarios[i] = TimeOfDay(
          hour: settings.expedientes[i].fim[0],
          minute: settings.expedientes[i].fim[1],
        );

        pausaHorarios[i] = TimeOfDay(
          hour: settings.expedientes[i].pausa[0],
          minute: settings.expedientes[i].pausa[1],
        );

        retornoHorarios[i] = TimeOfDay(
          hour: settings.expedientes[i].retorno[0],
          minute: settings.expedientes[i].retorno[1],
        );

        _activeDays.insert(0, settings.expedientes[i].aberto ?? true);
      }
      intervalSelected.value = settings.intervaloInMinutes;
      refresh();
    }
  }

  void toggleActiveDay(index) {
    print('index: $index');
    _activeDays[index] = !_activeDays[index];

    refresh();
  }

  void setHorarioInicio(index, horario) {
    inicioHorarios[index] = horario;
    _needSave.value = true;
    refresh();
  }

  void setHorarioFim(index, horario) {
    fimHorarios[index] = horario;
    _needSave.value = true;
    refresh();
  }

  void setHorarioPausa(index, horario) {
    pausaHorarios[index] = horario;
    _needSave.value = true;
    refresh();
  }

  void setHorarioRetorno(index, horario) {
    retornoHorarios[index] = horario;
    _needSave.value = true;
    refresh();
  }

  void saveData() {
    List<ExpedienteDay> expedienteDays = [];
    for (int i = 0; i < 7; i++) {
      expedienteDays.add(
        ExpedienteDay(
          inicio: [inicioHorarios[i].hour, inicioHorarios[i].minute],
          fim: [fimHorarios[i].hour, fimHorarios[i].minute],
          pausa: [pausaHorarios[i].hour, pausaHorarios[i].minute],
          retorno: [retornoHorarios[i].hour, retornoHorarios[i].minute],
        ),
      );
    }

    ExpedienteSettings settings = ExpedienteSettings(
      intervaloInMinutes: intervalSelected.value,
      expedientes: expedienteDays,
    );

    _localDataHelper.saveExpedienteSettings(settings);
    Fluttertoast.showToast(msg: 'Salvo');
    _needSave.value = false;
  }

  void limparDados() {
    _localDataHelper.limpaGeral();
  }
}
