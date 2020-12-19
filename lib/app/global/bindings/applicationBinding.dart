import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LocalDataHelper>(LocalDataHelper());
    Get.put<Uuid>(Uuid());
  }
}
