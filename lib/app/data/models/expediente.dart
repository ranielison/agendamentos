import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'expediente.g.dart';

@HiveType(typeId: Constants.hiveExpedienteAdapter)
class ExpedienteDay {
  @HiveField(0)
  List<int> inicio;

  @HiveField(1)
  List<int> pausa;

  @HiveField(2)
  List<int> retorno;

  @HiveField(3)
  List<int> fim;

  @HiveField(4)
  bool aberto;

  ExpedienteDay({
    this.inicio,
    this.pausa,
    this.retorno,
    this.fim,
    this.aberto = true,
  });

  ExpedienteDay.fromJson(Map<String, dynamic> json) {
    inicio = json['inicio'].cast<int>();
    pausa = json['pausa'].cast<int>();
    retorno = json['retorno'].cast<int>();
    fim = json['fim'].cast<int>();
    aberto = json['aberto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inicio'] = this.inicio;
    data['pausa'] = this.pausa;
    data['retorno'] = this.retorno;
    data['fim'] = this.fim;
    data['aberto'] = this.aberto;
    return data;
  }
}
