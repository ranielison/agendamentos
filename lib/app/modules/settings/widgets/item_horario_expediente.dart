import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemHorarioExpediente extends StatelessWidget {
  final void Function(TimeOfDay) onSelect;
  final TimeOfDay horario;

  const ItemHorarioExpediente({
    Key key,
    this.onSelect,
    this.horario,
  }) : super(key: key);

  void _timePicker(BuildContext context) async {
    TimeOfDay horarioSelecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    onSelect(horarioSelecionado);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _timePicker(context),
      child: Container(
        child: Text(
          horario.format(context),
          style: TextStyle(
            color: Get.theme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
