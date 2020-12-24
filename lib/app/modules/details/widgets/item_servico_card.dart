import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemServicoCard extends StatelessWidget {
  final Servico servico;

  ItemServicoCard({
    Key key,
    this.servico,
  }) : super(key: key);

  String _durationFormatted() {
    return Constants.hformat.format(
      DateTime(2020).add(
        Duration(minutes: servico.durationInMinutes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Row(
            children: [
              Text(
                '- ${servico.description}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                '${_durationFormatted()}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 3),
              Icon(Icons.timelapse, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
