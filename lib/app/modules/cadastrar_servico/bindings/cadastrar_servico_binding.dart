import 'package:get/get.dart';
import 'package:agendamentos/app/modules/cadastrar_servico/controllers/cadastrar_servico_controller.dart';

class CadastrarServicoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastrarServicoController>(
      () => CadastrarServicoController(),
    );
  }
}
