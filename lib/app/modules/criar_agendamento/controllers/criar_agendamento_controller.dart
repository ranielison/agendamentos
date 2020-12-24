import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/data/models/horario.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CriarAgendamentoController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();
  final _agendaController = Get.find<AgendaController>();
  final _uuid = Get.find<Uuid>();

  final focusCliente = FocusNode();
  final focusContato = FocusNode();

  DateTime dataAgendamento;
  DateTime pausa;
  DateTime fim;
  Duration maxDuration;
  Rx<Duration> durationPreenchida = Duration().obs;

  List<Horario> allHorarios;

  String _clientField = '';
  String _contatoField = '';

  RxList<Servico> _servicos = <Servico>[].obs;
  List<Servico> get servicos => _servicos.toList();

  RxList<Servico> _servicosSelecionados = <Servico>[].obs;
  List<Servico> get servicosSelecionados => _servicosSelecionados.toList();

  RxBool _isRetorno = false.obs;
  bool get isRetorno => _isRetorno.value;

  @override
  onInit() {
    super.onInit();
    _getArguments();
    _getServicos();
    _calculeMaxDuration();
  }

  void _getArguments() {
    dataAgendamento = Get.arguments['date'];
    allHorarios = Get.arguments['horarios'];
    pausa = Get.arguments['pausa'];
    fim = Get.arguments['fim'];
  }

  void _getServicos() {
    List<Servico> servicosData = _localDataHelper.getAllServicos() ?? [];
    _servicos.assignAll(servicosData);
  }

  void _calculeMaxDuration() {
    ExpedienteSettings exps = _localDataHelper.loadExpedienteSettings();

    int horariosVagos = 1;
    int index =
        allHorarios.indexWhere((element) => element.start == dataAgendamento);
    DateTime horarioFinal;

    if (index >= 0) {
      for (var i = index + 1; i < allHorarios.length; i++) {
        if (pausa != null && dataAgendamento.compareTo(pausa) <= 0) {
          horarioFinal = pausa;
        } else {
          horarioFinal = fim;
        }

        if (allHorarios[i].livre &&
            allHorarios[i].start.compareTo(horarioFinal) <= 0) {
          horariosVagos++;
        }
      }
    }
    maxDuration = Duration(
      minutes: horariosVagos * exps.intervaloInMinutes,
    );
    print(maxDuration.abs());
  }

  bool get durationPermitida {
    return durationPreenchida.value <= maxDuration;
  }

  void setClientField(String value) {
    _clientField = value;
  }

  void setContatoField(String value) {
    _contatoField = value;
  }

  void toogleCheckboxRetorno(bool value) {
    _isRetorno.value = value;
  }

  void addServico(Servico servico) {
    _servicosSelecionados.add(servico);
    durationPreenchida.value += Duration(minutes: servico.durationInMinutes);
  }

  void removeServico(Servico servico) {
    _servicosSelecionados.remove(servico);
    durationPreenchida.value -= Duration(minutes: servico.durationInMinutes);
  }

  void criarAgendamento() {
    if (_servicosSelecionados.isEmpty || !durationPermitida) return;

    Agendamento agendamento = Agendamento(
      idAgendamento: _uuid.v1(),
      cliente: Cliente(
        nome: _clientField,
        telefone: _contatoField.isNotEmpty ? _contatoField : null,
      ),
      isRetorno: _isRetorno.value,
      durationInMinutes: _servicosSelecionados.fold(
        0,
        (previousValue, element) => previousValue + element.durationInMinutes,
      ),
      startDate: dataAgendamento,
      servicos: servicosSelecionados,
    );

    _localDataHelper.addAgendamento(agendamento);
    _agendaController.addEventToSelectedEvents(agendamento);
    Get.until((route) => Get.currentRoute == Routes.AGENDA);
  }
}
