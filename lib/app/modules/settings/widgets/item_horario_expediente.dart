import 'package:flutter/material.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class ItemHorarioExpediente extends StatelessWidget {
  final void Function(TimeOfDay) onSelect;
  final TimeOfDay horario;
  final Color colorItem;
  final bool active;
  //final int interval;

  const ItemHorarioExpediente({
    Key key,
    @required this.onSelect,
    @required this.horario,
    @required this.colorItem,
    this.active,
    //@required this.interval,
  }) : super(key: key);

  void _timePicker(BuildContext context) async {
    TimeOfDay horarioSelecionado = await showIntervalTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      //interval: interval,
      //visibleStep: interval == 15 ? VisibleStep.Fifteenths : VisibleStep.Thirtieths,
    );

    if (horarioSelecionado != null) {
      onSelect(horarioSelecionado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _timePicker(context),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 20,
        ),
        alignment: Alignment.center,
        child: Visibility(
          visible: active ?? true,
          child: Text(
            horario.format(context),
            style: TextStyle(
              color: colorItem,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          replacement: Text(
            '-',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
