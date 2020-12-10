import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/agendamento.dart';
import 'package:agendamentos/app/utils/constants.dart';

class ItemHorarioOcupado extends StatelessWidget {
  final Agendamento agendamento;

  const ItemHorarioOcupado({Key key, this.agendamento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.DETAILS,
        arguments: {
          'agendamento': agendamento,
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
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agendamento.cliente.nome,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${Constants.hformat.format(agendamento.startDate)} - ${Constants.hformat.format(agendamento.startDate.add(Duration(minutes: agendamento.durationInMinutes)))}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          )),
    );
  }
}
