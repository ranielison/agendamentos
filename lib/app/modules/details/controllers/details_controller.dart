import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  Agendamento agendamento;

  @override
  void onInit() {
    super.onInit();
    _getArguments();
  }

  void _getArguments() {
    agendamento = Get.arguments['agendamento'];
  }
}
