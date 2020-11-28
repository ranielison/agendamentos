import 'package:agendamentos/app/modules/agenda/widgets/calendar.dart';
import 'package:agendamentos/app/modules/lista_servicos/views/lista_servicos_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
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
          Expanded(
            child: Obx(
              () => ListaServicosView(
                agendamentos: controller.selectedEvents,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
