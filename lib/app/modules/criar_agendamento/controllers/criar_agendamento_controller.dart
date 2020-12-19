import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';
import 'package:get/get.dart';

class CriarAgendamentoController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();
  final _agendaController = Get.find<AgendaController>();

  DateTime dataAgendamento;

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
  }

  void _getArguments() {
    dataAgendamento = Get.arguments['date'];
  }

  void _getServicos() {
    List<Servico> servicosData = _localDataHelper.getAllServicos() ?? [];
    _servicos.assignAll(servicosData);
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
  }

  void removeServico(Servico servico) {
    _servicosSelecionados.remove(servico);
  }

  void criarAgendamento() {
    if (_servicosSelecionados.isEmpty) {
      //Exibir mensagem avisando para adicionar serviços
      return;
    }
    Agendamento agendamento = Agendamento(
      cliente: Cliente(
        nome: _clientField,
        telefone: _contatoField,
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
    _agendaController.initListAgendamentos();
    Get.back();
    Get.back();
  }
}
