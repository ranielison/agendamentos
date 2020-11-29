import 'package:agendamentos/app/modules/lista_horarios/controllers/lista_horarios_controller.dart';
import 'package:get/get.dart';

class ListaHorariosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListaHorariosController>(
      () => ListaHorariosController(),
    );
  }
}
