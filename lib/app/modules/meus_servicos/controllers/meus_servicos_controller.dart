import 'package:get/get.dart';

class MeusServicosController extends GetxController {
  String _servicoField = '';
  String _durationField = '';

  void setServicoField(String value) {
    _servicoField = value;
  }

  void setDurationField(String value) {
    _durationField = value;
  }
}
