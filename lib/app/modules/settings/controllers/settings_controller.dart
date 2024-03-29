import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/global/widgets/modal_share_options.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
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

const List<String> shareOptionsList = [
  'com.google.android.gm',
  'com.google.android.apps.docs',
];

class SettingsController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();

  RxBool _needSave = false.obs;
  bool get needSave => _needSave.value;
  setNeedSave(bool value) => _needSave.value = value;

  RxBool _loadingExport = false.obs;
  bool get loadingExport => _loadingExport.value;

  RxBool _loadingImport = false.obs;
  bool get loadingImport => _loadingImport.value;

  RxInt intervalSelected = 15.obs;

  RxList<bool> _activeDays = List.generate(7, (index) => true).obs;
  List<bool> get activeDays => _activeDays.toList();

  RxList<bool> _halfDays = List.generate(7, (index) => true).obs;
  List<bool> get halfDays => _halfDays.toList();

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
      _activeDays.clear();
      _halfDays.clear();
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

        _activeDays.add(settings.expedientes[i].aberto ?? true);
        _halfDays.add(settings.expedientes[i].pausa[0] == -1);
      }
      intervalSelected.value = settings.intervaloInMinutes;
      refresh();
    } else {
      settings = allExpedientes;
      _localDataHelper.saveExpedienteSettings(settings);
      _loadData();
    }
  }

  void toggleActiveDay(index) {
    if (_halfDays[index] && !_activeDays[index]) {
      _activeDays[index] = true;
      _halfDays[index] = false;
      pausaHorarios[index] = TimeOfDay(
        hour: 12,
        minute: 0,
      );

      retornoHorarios[index] = TimeOfDay(
        hour: 14,
        minute: 0,
      );
    } else if (!_halfDays[index]) {
      _halfDays[index] = true;
    } else if (_activeDays[index]) {
      _activeDays[index] = false;
    }
    _needSave.value = true;
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
          pausa: _halfDays[i]
              ? [-1, -1]
              : [pausaHorarios[i].hour, pausaHorarios[i].minute],
          retorno: _halfDays[i]
              ? [-1, -1]
              : [retornoHorarios[i].hour, retornoHorarios[i].minute],
          aberto: _activeDays[i],
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

  void createbackup() async {
    _loadingExport.value = true;
    final shareOptions = await _localDataHelper.buildJsonDataBackup();
    _loadingExport.value = false;

    Get.bottomSheet(
      ModalShareOptions(
        listaOptions: shareOptions
            .where(
              (op) => shareOptionsList.contains(op.activityInfo.packageName),
            )
            .toList(),
      ),
    );
  }

  void restoreJsonDataBackup() async {
    FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      allowedFileExtensions: ['json'],
      allowedMimeTypes: ['application/*'],
      invalidFileNameSymbols: ['/'],
    );

    final path = await FlutterDocumentPicker.openDocument(params: params);
    try {
      await _localDataHelper.restoreJsonDataBackup(path);
      Fluttertoast.showToast(msg: 'Dados importados');
      Get.until((route) => Get.currentRoute == Routes.HOME);
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: Text('Erro', textAlign: TextAlign.center),
          content: Text('Não foi possível carregar o arquivo'),
          actions: [
            FlatButton(onPressed: () => Get.back(), child: Text('Ok')),
          ],
        ),
      );
    }
  }
}
