import 'package:agendamentos/app/data/models/horario.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemHorario extends StatelessWidget {
  final Horario horario;

  const ItemHorario({Key key, this.horario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            '${horario.start.hour}:${horario.start.minute}h - ${horario.start.add(horario.duration).hour}:${horario.start.add(horario.duration).minute}h',
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
    );
  }
}
