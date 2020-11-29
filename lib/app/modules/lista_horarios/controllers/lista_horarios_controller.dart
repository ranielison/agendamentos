import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/data/models/horario.dart';
import 'package:get/get.dart';

class ListaHorariosController extends GetxController {
  //Puxar definições de horário

  DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;

  RxList<Horario> _horarios = <Horario>[].obs;
  List<Horario> get horarios => _horarios;

  final allExpedientes = ExpedienteSettings(
    intervalo: Duration(minutes: 30),
    expedientes: [
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        pausa: DateTime(2020, 1, 1, 12),
        retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 18),
      ),
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        pausa: DateTime(2020, 1, 1, 12),
        retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 18),
      ),
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        pausa: DateTime(2020, 1, 1, 12),
        retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 18),
      ),
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        pausa: DateTime(2020, 1, 1, 12),
        retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 18),
      ),
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        pausa: DateTime(2020, 1, 1, 12),
        retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 18),
      ),
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        pausa: DateTime(2020, 1, 1, 12),
        retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 18),
      ),
      ExpedienteDay(
        aberto: true,
        inicio: DateTime(2020, 1, 1, 8),
        //pausa: DateTime(2020, 1, 1, 12),
        //retorno: DateTime(2020, 1, 1, 14),
        fim: DateTime(2020, 1, 1, 12),
      ),
    ],
  );

  @override
  onInit() {
    super.onInit();
    _getArguments();
    _generateList();
  }

  _getArguments() {
    _selectedDay = Get.arguments['day'];
  }

  _generateList() {
    Duration interval = allExpedientes.intervalo;
    DateTime inicio =
        allExpedientes.expedientes[_selectedDay.weekday - 1].inicio;
    DateTime pausa = allExpedientes.expedientes[_selectedDay.weekday - 1].pausa;
    DateTime retorno =
        allExpedientes.expedientes[_selectedDay.weekday - 1].retorno;
    DateTime fim = allExpedientes.expedientes[_selectedDay.weekday - 1].fim;

    DateTime atual = inicio;
    int laco = 0;
    while (true) {
      laco++;
      _horarios.add(
        Horario(
          start: atual,
          duration: interval,
          livre: true,
        ),
      );
      atual = atual.add(interval);

      if (pausa != null) {
        if (atual.compareTo(pausa) >= 0) {
          atual = retorno;
          pausa = null;
        }
      }

      if (atual.compareTo(fim) >= 0 || laco > 100) {
        break;
      }
    }
  }
}
