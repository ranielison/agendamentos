import 'package:get/get.dart';
import 'package:agendamentos/app/modules/criar_agendamento/controllers/criar_agendamento_controller.dart';

class CriarAgendamentoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CriarAgendamentoController>(
      CriarAgendamentoController(),
    );
  }
}
