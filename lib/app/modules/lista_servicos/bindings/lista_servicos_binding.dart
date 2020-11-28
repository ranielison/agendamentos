import 'package:get/get.dart';

import 'package:agendamentos/app/modules/lista_servicos/controllers/lista_servicos_controller.dart';

class ListaServicosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListaServicosController>(
      () => ListaServicosController(),
    );
  }
}
