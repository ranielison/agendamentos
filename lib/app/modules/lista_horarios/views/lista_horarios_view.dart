import 'package:agendamentos/app/data/models/horario.dart';
import 'package:agendamentos/app/modules/lista_horarios/controllers/lista_horarios_controller.dart';
import 'package:agendamentos/app/modules/lista_horarios/widgets/item_horario.dart';
import 'package:agendamentos/app/modules/lista_horarios/widgets/item_horario_ocupado.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:agendamentos/app/utils/no_animation_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaHorariosView extends GetView<ListaHorariosController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horários'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, color: Constants.grey),
                SizedBox(width: 5),
                Text(
                  '${controller.selectedDay.day}/${controller.selectedDay.month}/${controller.selectedDay.year}',
                  style: TextStyle(
                    color: Constants.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Visibility(
              visible: controller.horarios.isNotEmpty,
              child: NoAnimationList(
                child: ListView.builder(
                  itemCount: controller.horarios.length,
                  itemBuilder: (_, index) {
                    Horario horario = controller.horarios[index];

                    if (!horario.livre && horario.agendamento != null) {
                      return ItemHorarioOcupado(
                        agendamento: horario.agendamento,
                      );
                    } else if (horario.livre) {
                      return ItemHorario(
                        horario: horario,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              replacement: Center(
                child: Text(
                  'Fechado',
                  style: TextStyle(
                    color: Constants.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
