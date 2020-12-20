import 'package:agendamentos/app/data/models/horario.dart';
import 'package:agendamentos/app/modules/lista_horarios/controllers/lista_horarios_controller.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemHorario extends StatelessWidget {
  final Horario horario;

  ItemHorario({Key key, this.horario}) : super(key: key);

  final controller = Get.find<ListaHorariosController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.CRIAR_AGENDAMENTO,
        arguments: {
          'date': horario.start,
          'horarios': controller.horarios,
          'pausa': controller.pausa,
          'fim': controller.fim,
        },
      ),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1,
            color: Constants.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${Constants.hformat.format(horario.start)} - ${Constants.hformat.format(horario.start.add(Duration(minutes: horario.durationInMinutes)))}',
              style: TextStyle(
                color: Constants.grey,
                fontSize: 16,
              ),
            ),
            Text(
              horario.livre ? 'Livre' : 'Ocupado',
              style: TextStyle(
                color: Constants.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
