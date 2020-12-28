import 'package:agendamentos/app/modules/criar_agendamento/controllers/criar_agendamento_controller.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:agendamentos/app/data/models/servico.dart';
import 'package:get/get.dart';

class ItemServico extends StatelessWidget {
  final Servico servico;

  ItemServico({Key key, this.servico}) : super(key: key);

  final controller = Get.find<CriarAgendamentoController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      servico.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.timelapse, color: Colors.grey, size: 20),
                  SizedBox(width: 3),
                  Text(
                    Constants.hformat.format(
                      DateTime(2020).add(
                        Duration(minutes: servico.durationInMinutes),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.red[400]),
          onPressed: () => controller.removeServico(servico),
        )
      ],
    );
  }
}
