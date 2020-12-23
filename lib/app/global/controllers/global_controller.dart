import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  final _prefs = Get.find<SharedPreferences>();

  RxBool _showEventAmount = false.obs;
  bool get showEventAmount => _showEventAmount.value;

  GlobalController() {
    _loadData();
  }

  _loadData() {
    _showEventAmount.value = _prefs.getBool('eventAmount') ?? false;
  }

  void setShowEventAmount(bool value) async {
    _showEventAmount.value = value;
    await _prefs.setBool('eventAmount', value);
  }
}
