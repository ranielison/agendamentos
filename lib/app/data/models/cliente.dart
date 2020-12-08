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
}
