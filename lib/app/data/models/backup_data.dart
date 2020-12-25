import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/data/models/servico.dart';

class BackupData {
  List<Agendamento> agendamentos;
  List<Servico> servicos;
  ExpedienteSettings expedienteSettings;

  BackupData({
    this.agendamentos,
    this.servicos,
    this.expedienteSettings,
  });

  BackupData.fromJson(Map<String, dynamic> json) {
    agendamentos = json['agendamentos'] != null
        ? List<Agendamento>.from(
            json['agendamentos']
                .map((item) => Agendamento.fromJson(item))
                .toList(),
          )
        : null;
    servicos = json['servicos'] != null
        ? List<Servico>.from(
            json['servicos'].map((item) => Servico.fromJson(item)).toList(),
          )
        : null;
    expedienteSettings = ExpedienteSettings.fromJson(
      json['expediente_settings'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (agendamentos != null) {
      data['agendamentos'] = agendamentos.map((item) => item.toJson()).toList();
    }
    if (servicos != null) {
      data['servicos'] = servicos.map((item) => item.toJson()).toList();
    }
    data['expediente_settings'] = expedienteSettings;

    return data;
  }
}
