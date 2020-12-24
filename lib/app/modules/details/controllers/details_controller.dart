import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();
  final _agendaController = Get.find<AgendaController>();

  Agendamento agendamento;

  @override
  void onInit() {
    super.onInit();
    _getArguments();
  }

  void _getArguments() {
    agendamento = Get.arguments['agendamento'];
  }

  void deleteAgendamento() {
    if (agendamento != null) {
      _localDataHelper.deleteAgendamento(agendamento.idAgendamento);
      _agendaController.removeEventFromSelectedEvents(
        agendamento.idAgendamento,
      );
      Get.until((route) => Get.currentRoute == Routes.AGENDA);
    }
  }

  void finalizarAgendamento() {
    agendamento.concluido = true;
    _localDataHelper.updateAgendamento(agendamento);
    _agendaController.updateEventOnSelectedEvents(agendamento);
    Get.until((route) => Get.currentRoute == Routes.AGENDA);
  }

  void openOnWhatsapp() {
    String telefone = agendamento.cliente.telefone;
    if (telefone != null) {
      String number = telefone
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('-', '')
          .replaceAll(' ', '');

      launch('https://api.whatsapp.com/send?phone=55$number&text= ');
    }
  }
}
