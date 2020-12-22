import 'package:agendamentos/app/global/controllers/global_controller.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LocalDataHelper>(LocalDataHelper());
    Get.put<Uuid>(Uuid());
    Get.put<GlobalController>(GlobalController());
  }
}
