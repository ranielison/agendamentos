import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'servico.g.dart';

@HiveType(typeId: Constants.hiveServicoAdapter)
class Servico {
  @HiveField(0)
  String id;

  @HiveField(1)
  String description;

  @HiveField(2)
  double value;

  @HiveField(3)
  int durationInMinutes;

  Servico({
    this.id,
    this.description,
    this.value,
    this.durationInMinutes,
  });
}
