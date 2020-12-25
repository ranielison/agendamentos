import 'dart:convert';
import 'dart:io';

import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/backup_data.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataHelper {
  Box _box;

  Map<String, dynamic> _json = {};
  String _jsonString;
  bool _fileExists = false;
  File _filePath;

  LocalDataHelper() {
    _getBox();
  }
  _getBox() async {
    _box = await Hive.openBox('spadonabonita');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${Constants.fileBackupName}');
  }

  void _writeJson(String key, dynamic value) async {
    // Initialize the local _filePath
    final _filePath = await _localFile;

    //1. Create _newJson<Map> from input<TextField>
    Map<String, dynamic> _newJson = {key: value};
    print('1.(_writeJson) _newJson: $_newJson');

    //2. Update _json by adding _newJson<Map> -> _json<Map>
    _json.addAll(_newJson);
    print('2.(_writeJson) _json(updated): $_json');

    //3. Convert _json ->_jsonString
    _jsonString = jsonEncode(_json);
    print('3.(_writeJson) _jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    _filePath.writeAsString(_jsonString);
  }

  Future<dynamic> _readJson() async {
    // Initialize _filePath
    _filePath = await _localFile;

    // 0. Check whether the _file exists
    _fileExists = await _filePath.exists();
    print('0. File exists? $_fileExists');

    // If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        _jsonString = await _filePath.readAsString();
        print('1.(_readJson) _jsonString: $_jsonString');

        //2. Update initialized _json by converting _jsonString<String>->_json<Map>
        _json = jsonDecode(_jsonString);
        print('2.(_readJson) _json: $_json \n - \n');
        return _json;
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
  }

  limpaGeral() {
    _box.clear();
  }

  List<Agendamento> getAgendamentos() {
    var agendamentos = _box.get('agendamentos');
    return List<Agendamento>.from(agendamentos ?? []);
  }

  void addAgendamento(Agendamento agendamento) {
    dynamic agendamentos = _box.get('agendamentos');

    if (agendamentos != null) {
      agendamentos.add(agendamento);
      _box.put('agendamentos', agendamentos);
    } else {
      _box.put('agendamentos', [agendamento]);
    }
  }

  void deleteAgendamento(String id) {
    dynamic agendamentos = _box.get('agendamentos');

    try {
      if (agendamentos != null) {
        int indexAgendamento = (agendamentos as List).indexWhere(
          (element) => element.idAgendamento == id,
        );
        if (indexAgendamento >= 0) {
          (agendamentos as List).removeAt(indexAgendamento);
        }
        _box.put('agendamentos', agendamentos);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void updateAgendamento(Agendamento newAgendamento) {
    dynamic agendamentos = _box.get('agendamentos');

    if (agendamentos != null) {
      int indexAgendamento = (agendamentos as List).indexWhere(
        (element) => element.idAgendamento == newAgendamento.idAgendamento,
      );
      if (indexAgendamento >= 0) {
        agendamentos[indexAgendamento] = newAgendamento;
      }
      _box.put('agendamentos', agendamentos);
    }
  }

  void saveExpedienteSettings(ExpedienteSettings settings) {
    try {
      _box.put('expediente_settings', settings);
    } on Exception catch (e) {
      print(e);
    }
  }

  ExpedienteSettings loadExpedienteSettings() {
    return _box.get('expediente_settings');
  }

  void addServico(Servico servico) {
    dynamic meusServicos = _box.get('meus_servicos');

    if (meusServicos != null) {
      meusServicos.add(servico);
    } else {
      meusServicos = [servico];
    }

    _box.put('meus_servicos', meusServicos);
  }

  void editServico(Servico servico) {
    dynamic meusServicos = _box.get('meus_servicos');

    if (meusServicos != null) {
      int index = meusServicos.indexWhere((item) => item.id == servico.id);
      if (index >= 0) {
        meusServicos[index] = servico;
      }
    }
  }

  void excluirServico(String id) {
    dynamic meusServicos = _box.get('meus_servicos');

    if (meusServicos != null) {
      int index = meusServicos.indexWhere((item) => item.id == id);
      if (index >= 0) {
        meusServicos.removeAt(index);
      }
    }
  }

  List<Servico> getAllServicos() {
    var data = _box.get('meus_servicos');
    if (data != null) {
      return List<Servico>.from(data);
    }
    return null;
  }

  void buildJsonDataBackup() {
    var agendamentos = _box.get('agendamentos');
    var settings = _box.get('expediente_settings');
    var servicos = _box.get('meus_servicos');

    BackupData backup = BackupData(
      agendamentos: List<Agendamento>.from(agendamentos),
      expedienteSettings: settings,
      servicos: List<Servico>.from(servicos),
    );

    Map backupJson = backup.toJson();
    print('BACKUP');
    print(backupJson);
    _writeJson('backup', backupJson);
  }

  void restoreJsonDataBackup() async {
    dynamic fileBackup = await _readJson();
    BackupData backup = BackupData.fromJson(fileBackup['backup']);

    _box.put('meus_servicos', backup.servicos);
    _box.put('agendamentos', backup.agendamentos);
    _box.put('expediente_settings', backup.expedienteSettings);
  }
}
