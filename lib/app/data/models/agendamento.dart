import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'agendamento.g.dart';

@HiveType(typeId: Constants.hiveAgendamentoAdapter)
class Agendamento {
  @HiveField(0)
  Cliente cliente;

  @HiveField(1)
  Duration duration;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  List<Servico> servicos;

  @HiveField(4)
  bool isRetorno;

  @HiveField(5)
  bool concluido;

  Agendamento({
    this.cliente,
    this.duration,
    this.startDate,
    this.servicos,
    this.isRetorno = false,
    this.concluido = false,
  });
}
