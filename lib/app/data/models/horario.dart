import 'package:agendamentos/app/data/models/agendamento.dart';

class Horario {
  DateTime start;
  Duration duration;
  Agendamento agendamento;
  bool livre;

  Horario({
    this.start,
    this.duration,
    this.agendamento,
    this.livre,
  });
}
