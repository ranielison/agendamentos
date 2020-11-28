import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';

class Agendamento {
  Cliente cliente;
  Duration duration;
  DateTime startDate;
  List<Servico> servicos;
  bool isRetorno;
  bool concluido;

  Agendamento({
    this.cliente,
    this.duration,
    this.startDate,
    this.servicos,
    this.isRetorno,
    this.concluido,
  });
}
