import 'package:agendamentos/app/data/models/agendamento.dart';
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

  List<Agendamento> _agendamentos;

  final allExpedientes = ExpedienteSettings(
    intervalo: Duration(minutes: 30),
    expedientes: [
      ExpedienteDay(
        inicio: [8, 0],
        pausa: [12, 0],
        retorno: [14, 0],
        fim: [18, 0],
      ),
      ExpedienteDay(
        inicio: [8, 0],
        pausa: [12, 0],
        retorno: [14, 0],
        fim: [18, 0],
      ),
      ExpedienteDay(
        inicio: [8, 0],
        pausa: [12, 0],
        retorno: [14, 0],
        fim: [18, 0],
      ),
      ExpedienteDay(
        inicio: [8, 0],
        pausa: [12, 0],
        retorno: [14, 0],
        fim: [18, 0],
      ),
      ExpedienteDay(
        inicio: [8, 0],
        pausa: [12, 0],
        retorno: [14, 0],
        fim: [18, 0],
      ),
      ExpedienteDay(
        inicio: [8, 0],
        fim: [12, 0],
      ),
      ExpedienteDay(
        aberto: false,
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
    _agendamentos = List<Agendamento>.from(Get.arguments['agendamentos']);
  }

  _generateList() {
    int position = _selectedDay.weekday - 1;
    Duration interval = allExpedientes.intervalo;

    if (!allExpedientes.expedientes[position].aberto) return;

    DateTime inicio = _selectedDay.add(
      Duration(
        hours: allExpedientes.expedientes[position].inicio[0],
        minutes: allExpedientes.expedientes[position].inicio[1],
      ),
    );

    DateTime fim = _selectedDay.add(
      Duration(
        hours: allExpedientes.expedientes[position].fim[0],
        minutes: allExpedientes.expedientes[position].fim[1],
      ),
    );

    DateTime pausa;
    DateTime retorno;

    if (allExpedientes.expedientes[position].pausa != null) {
      pausa = _selectedDay.add(
        Duration(
          hours: allExpedientes.expedientes[position].pausa[0],
          minutes: allExpedientes.expedientes[position].pausa[1],
        ),
      );

      retorno = _selectedDay.add(
        Duration(
          hours: allExpedientes.expedientes[position].retorno[0],
          minutes: allExpedientes.expedientes[position].retorno[1],
        ),
      );
    }

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

    int indHorario = 0;
    if (_agendamentos?.isNotEmpty ?? false) {
      _agendamentos.forEach((element) {
        DateTime inicio = element.startDate;
        DateTime fim = element.startDate.add(element.duration);
        //Duration agDuration = element.duration;

        for (var i = indHorario; i < _horarios.length; i++) {
          DateTime inicioHorario = _horarios[i].start;
          int diffInicio = inicioHorario.compareTo(inicio);
          DateTime fimHorario = _horarios[i].start.add(_horarios[i].duration);
          int diffFim = fimHorario.compareTo(fim);

          if (diffInicio >= 0 && diffFim <= 0) {
            _horarios[i].livre = false;
          } else {
            indHorario = i;
            break;
          }
        }
      });
    }
  }
}
