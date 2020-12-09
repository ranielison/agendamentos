import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'expediente_settings.g.dart';

@HiveType(typeId: Constants.hiveExpedienteSettingsAdapter)
class ExpedienteSettings {
  @HiveField(0)
  int intervaloInMinutes;

  @HiveField(1)
  List<ExpedienteDay> expedientes;

  ExpedienteSettings({
    this.intervaloInMinutes,
    this.expedientes,
  });
}
