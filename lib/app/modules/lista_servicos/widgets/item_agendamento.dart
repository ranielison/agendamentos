import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:flutter/material.dart';

class ItemAgendamento extends StatelessWidget {
  final Agendamento agendamento;

  const ItemAgendamento({Key key, this.agendamento}) : super(key: key);

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
                '13:00h - 14:45h',
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
              Icons.timer,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
