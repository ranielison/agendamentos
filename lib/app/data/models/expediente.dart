import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'expediente.g.dart';

@HiveType(typeId: Constants.hiveExpedienteAdapter)
class ExpedienteDay {
  @HiveField(0)
  final List<int> inicio;

  @HiveField(1)
  final List<int> pausa;

  @HiveField(2)
  final List<int> retorno;

  @HiveField(3)
  final List<int> fim;

  @HiveField(4)
  final bool aberto;

  ExpedienteDay({
    this.inicio,
    this.pausa,
    this.retorno,
    this.fim,
    this.aberto = true,
  });
}
