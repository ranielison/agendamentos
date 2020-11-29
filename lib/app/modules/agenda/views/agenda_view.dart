import 'package:agendamentos/app/modules/agenda/widgets/calendar.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgendaView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Calendar(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Agendamentos de hoje',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.crop_free,
                    color: Get.theme.primaryColor,
                  ),
                  onPressed: () => Get.toNamed(Routes.LISTA_HORARIOS),
                )
              ],
            ),
          )
          /*Expanded(
            child: Obx(
              () => ListaServicosView(
                agendamentos: controller.selectedEvents,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
