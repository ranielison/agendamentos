import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';

class CriarAgendamentoController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();

  DateTime dataAgendamento;

  String _clientField = '';
  String _contatoField = '';

  RxList<Servico> _servicos = <Servico>[].obs;
  List<Servico> get servicos => _servicos.toList();

  RxList<Servico> _servicosSelecionados = <Servico>[].obs;
  List<Servico> get servicosSelecionados => _servicosSelecionados.toList();

  Rx<Servico> _servicoSelecetd = Servico().obs;
  Servico get servicoSelected => _servicoSelecetd.value;

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
    _servicos.assignAll(servicosMock);
    _servicoSelecetd.value = _servicos?.first;
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

  void setServiceSelected(Servico servico) {
    _servicoSelecetd.value = servico;
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
    Get.back();
  }
}
