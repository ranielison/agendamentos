import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/modules/agenda/widgets/calendar.dart';
import 'package:agendamentos/app/modules/agenda/widgets/list_agendamentos.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
  final DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha agenda'),
      ),
      body: Column(
        children: [
          GetBuilder<AgendaController>(
            builder: (_) {
              return Calendar();
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    'Agendamentos de ${Constants.dformat.format(controller.selectedDay)}',
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.selectedDay.compareTo(today) >= 0 &&
                        controller.dayIsOpen(controller.selectedDay),
                    child: IconButton(
                      icon: Icon(
                        Icons.crop_free,
                        color: Get.theme.primaryColor,
                      ),
                      onPressed: () => Get.toNamed(
                        Routes.LISTA_HORARIOS,
                        arguments: {
                          'day': controller.selectedDay,
                          'agendamentos': controller.selectedEvents,
                        },
                      ),
                    ),
                    replacement: SizedBox(height: 40),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListAgendamentos(
                agendamentos: List<Agendamento>.from(controller.selectedEvents),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
