import 'package:get/get.dart';

import 'package:agendamentos/app/modules/meus_servicos/controllers/meus_servicos_controller.dart';

class MeusServicosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeusServicosController>(
      () => MeusServicosController(),
    );
  }
}
