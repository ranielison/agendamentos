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
  bool isRetorno;

  @HiveField(6)
  bool concluido;

  Agendamento({
    this.cliente,
    this.durationInMinutes,
    this.startDate,
    this.servicos,
    this.isRetorno = false,
    this.concluido = false,
  });
}
