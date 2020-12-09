import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();

  void limparDados() {
    _localDataHelper.limpaGeral();
  }
}
