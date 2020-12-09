import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'horario.g.dart';

@HiveType(typeId: Constants.hiveHoraioAdapter)
class Horario {
  @HiveField(0)
  DateTime start;

  @HiveField(1)
  int durationInMinutes;

  @HiveField(2)
  Agendamento agendamento;

  @HiveField(3)
  bool livre;

  Horario({
    this.start,
    this.durationInMinutes,
    this.agendamento,
    this.livre,
  });
}
