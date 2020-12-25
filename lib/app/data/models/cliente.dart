import 'package:agendamentos/app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'cliente.g.dart';

@HiveType(typeId: Constants.hiveClienteAdapter)
class Cliente {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String telefone;

  @HiveField(2)
  String dataNascimento;

  Cliente({
    this.nome,
    this.telefone,
    this.dataNascimento,
  });

  Cliente.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    telefone = json['telefone'];
    dataNascimento = json['data_nascimento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['data_nascimento'] = this.dataNascimento;

    return data;
  }
}
