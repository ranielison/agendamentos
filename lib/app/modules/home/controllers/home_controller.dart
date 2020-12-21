import 'package:agendamentos/app/data/mocks/agendamentos_mock.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();

  @override
  void onInit() {
    super.onInit();
    _initDataBase();
  }

  void _initDataBase() {
    ExpedienteSettings exps = _localDataHelper.loadExpedienteSettings();

    if (exps == null) {
      exps = allExpedientes;
      _localDataHelper.saveExpedienteSettings(exps);
    }
  }
}
