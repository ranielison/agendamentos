import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LocalDataHelper>(LocalDataHelper());
  }
}
