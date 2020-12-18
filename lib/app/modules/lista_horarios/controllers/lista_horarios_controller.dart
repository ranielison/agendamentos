import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/data/models/horario.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';

class ListaHorariosController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();

  DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;

  RxList<Horario> _horarios = <Horario>[].obs;
  List<Horario> get horarios => _horarios;

  List<Agendamento> _agendamentos;

  @override
  onInit() {
    super.onInit();
    _getArguments();
    _generateList();
  }

  void _getArguments() {
    _selectedDay = Get.arguments['day'];
    _agendamentos = List<Agendamento>.from(Get.arguments['agendamentos']);
  }

  void _generateList() {
    ExpedienteSettings allExpedientes;
    int position;
    int interval;

    allExpedientes = _localDataHelper.loadExpedienteSettings();

    position = _selectedDay.weekday - 1;
    interval = allExpedientes.intervaloInMinutes;

    DateTime today = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );

    if (!allExpedientes.expedientes[position].aberto) return;

    DateTime inicio = today.add(
      Duration(
        hours: allExpedientes.expedientes[position].inicio[0],
        minutes: allExpedientes.expedientes[position].inicio[1],
      ),
    );

    DateTime fim = today.add(
      Duration(
        hours: allExpedientes.expedientes[position].fim[0],
        minutes: allExpedientes.expedientes[position].fim[1],
      ),
    );

    DateTime pausa;
    DateTime retorno;

    if (allExpedientes.expedientes[position].pausa[0] != -1) {
      pausa = today.add(
        Duration(
          hours: allExpedientes.expedientes[position].pausa[0],
          minutes: allExpedientes.expedientes[position].pausa[1],
        ),
      );

      retorno = today.add(
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
          durationInMinutes: interval,
          livre: true,
        ),
      );
      atual = atual.add(Duration(minutes: interval));

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

    if (_agendamentos?.isNotEmpty ?? false) {
      _agendamentos.forEach(
        (element) {
          int indHorario = 0;
          bool agendamentoAtribuido = false;
          DateTime inicio = element.startDate;
          DateTime fim = element.startDate.add(
            Duration(
              minutes: element.durationInMinutes,
            ),
          );

          for (var i = indHorario; i < _horarios.length; i++) {
            DateTime inicioHorario = _horarios[i].start;
            int diffInicio = inicioHorario.compareTo(inicio);
            DateTime fimHorario = _horarios[i].start.add(
                  Duration(
                    minutes: _horarios[i].durationInMinutes,
                  ),
                );
            int diffFim = fimHorario.compareTo(fim);

            if (diffInicio >= 0 && diffFim <= 0) {
              _horarios[i].livre = false;
              if (!agendamentoAtribuido) {
                _horarios[i].agendamento = element;
                agendamentoAtribuido = true;
              }
            } else {
              indHorario = i;
            }
          }
        },
      );
    }
  }
}
