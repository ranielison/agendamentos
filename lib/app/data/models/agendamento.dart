import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'agendamento.g.dart';

@HiveType(typeId: Constants.hiveAgendamentoAdapter)
class Agendamento {
  @HiveField(0)
  String idAgendamento;

  @HiveField(1)
  Cliente cliente;

  @HiveField(2)
  int durationInMinutes;

  @HiveField(3)
  DateTime startDate;

  @HiveField(4)
  List<Servico> servicos;

  @HiveField(5)
  bool concluido;

  Agendamento({
    this.idAgendamento,
    this.cliente,
    this.durationInMinutes,
    this.startDate,
    this.servicos,
    this.concluido = false,
  });

  Agendamento.fromJson(Map<String, dynamic> json) {
    idAgendamento = json['id_agendamento'];
    cliente =
        json['cliente'] != null ? Cliente.fromJson(json['cliente']) : null;
    durationInMinutes = json['duration_in_minutes'];
    startDate = DateTime.parse(json['start_date']);
    servicos = json['servicos'] != null
        ? List<Servico>.from(
            json['servicos'].map((item) => Servico.fromJson(item)).toList(),
          )
        : null;
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_agendamento'] = this.idAgendamento;
    if (cliente != null) {
      data['cliente'] = this.cliente.toJson();
    }
    data['duration_in_minutes'] = this.durationInMinutes;
    data['start_date'] = this.startDate.toString();
    if (servicos != null) {
      data['servicos'] = this.servicos.map((s) => s.toJson()).toList();
    }
    data['concluido'] = this.concluido;

    return data;
  }
}
