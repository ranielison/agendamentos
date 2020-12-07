import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:get/get.dart';

class CriarAgendamentoController extends GetxController {
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
    _getServicos();
  }

  _getServicos() {
    _servicos.assignAll(servicosMock);
    _servicoSelecetd.value = _servicos?.first;
  }

  toogleCheckboxRetorno(bool value) {
    _isRetorno.value = value;
  }

  setServiceSelected(Servico servico) {
    _servicoSelecetd.value = servico;
  }

  addServico() {
    if (_servicoSelecetd.value == null) return;
    _servicosSelecionados.add(_servicoSelecetd.value);
  }

  criarAgendamento() {
    Agendamento agendamento = Agendamento(
      cliente: Cliente(
        nome: 'Ranielison', // Pegar do campo
        telefone: '(84) 998306460', //Pegar do campo
      ),
      concluido: false,
      isRetorno: false, //add checkbox de retorno
      duration: Duration(hours: 1), //Somar durações dos serviços selecionados
      startDate: DateTime.now(), // Colocar data selecionada
      servicos: servicosSelecionados,
    );

    //Adicionar o agendamento no banco
  }
}
