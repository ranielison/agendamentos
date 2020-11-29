import 'package:agendamentos/app/data/models/expediente.dart';

class ExpedienteSettings {
  Duration intervalo;
  List<ExpedienteDay> expedientes;

  ExpedienteSettings({
    this.intervalo,
    this.expedientes,
  });
}
