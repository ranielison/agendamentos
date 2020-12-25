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

  ExpedienteSettings.fromJson(Map<String, dynamic> json) {
    intervaloInMinutes = json['intervalo_in_minutes'];
    expedientes = json['expedientes'] != null
        ? List<ExpedienteDay>.from(
            json['expedientes']
                .map((item) => ExpedienteDay.fromJson(item))
                .toList(),
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intervalo_in_minutes'] = this.intervaloInMinutes;
    if (expedientes != null) {
      data['expedientes'] = expedientes.map((item) => item.toJson()).toList();
    }
    return data;
  }
}
