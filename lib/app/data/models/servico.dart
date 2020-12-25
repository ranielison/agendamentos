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

  Servico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    value = json['value'];
    durationInMinutes = json['duration_in_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['value'] = this.value;
    data['duration_in_minutes'] = this.durationInMinutes;
    return data;
  }
}
