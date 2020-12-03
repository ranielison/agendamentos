import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/modules/lista_horarios/widgets/item_agendamento.dart';
import 'package:flutter/material.dart';

class ListAgendamentos extends StatelessWidget {
  final List<Agendamento> agendamentos;

  const ListAgendamentos({
    Key key,
    this.agendamentos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: agendamentos?.length ?? 0,
      itemBuilder: (_, index) {
        return ItemAgendamento(
          agendamento: agendamentos[index],
        );
      },
    );
  }
}
