import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:hive/hive.dart';

class LocalDataHelper {
  Box _box;

  LocalDataHelper() {
    _getBox();
  }

  _getBox() async {
    _box = await Hive.openBox('spadonabonita');
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
          (element) => element.id == id,
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
}
