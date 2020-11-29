import 'package:agendamentos/app/modules/lista_horarios/controllers/lista_horarios_controller.dart';
import 'package:agendamentos/app/modules/lista_horarios/widgets/item_horario.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaHorariosView extends GetView<ListaHorariosController> {
  final DateTime date;

  ListaHorariosView({this.date});

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
                  '20/12/2020',
                  style: TextStyle(
                    color: Constants.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index) {
                //Agendamento ag = agendamentos[index];

                return ItemHorario();
              },
            ),
          ),
        ],
      ),
    );
  }
}
