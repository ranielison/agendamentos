import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemAgendamento extends StatelessWidget {
  final Agendamento agendamento;

  const ItemAgendamento({
    Key key,
    this.agendamento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: Text('1', style: TextStyle(color: Colors.grey)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                agendamento.cliente.nome,
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 16,
                ),
              ),
              Text(
                '${Constants.hformat.format(agendamento.startDate)} - ${Constants.hformat.format(agendamento.startDate.add(Duration(minutes: agendamento.durationInMinutes)))}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              agendamento.concluido ? Icons.check : Icons.timer,
              color: agendamento.concluido ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
