import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxBool _showEventAmount = false.obs;
  bool get showEventAmount => _showEventAmount.value;

  void setShowEventAmount(bool value) {
    _showEventAmount.value = value;
  }
}
