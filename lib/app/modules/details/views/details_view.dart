import 'package:agendamentos/app/modules/details/widgets/action_button.dart';
import 'package:agendamentos/app/modules/details/widgets/card_servicos.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/details/controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Constants.dhformat.format(controller.agendamento.startDate),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    controller.agendamento.cliente.nome,
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Visibility(
                    visible: controller.agendamento.concluido,
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    replacement: Icon(
                      Icons.timer,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 64,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contato',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        controller.agendamento.cliente.telefone ?? '-',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.phone, color: Colors.white),
                    onPressed: controller.openOnWhatsapp,
                  ),
                ],
              ),
            ),
            CardServicos(
              servicos: controller.agendamento.servicos,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Duração total: ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    Constants.hformat.format(
                      DateTime(2020).add(
                        Duration(
                          minutes: controller.agendamento.durationInMinutes,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.timelapse,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Visibility(
              visible: !controller.agendamento.concluido,
              child: Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      textButton: 'Cancelar',
                      colorButton: Colors.red[400],
                      action: () {
                        Get.dialog(AlertDialog(
                          title: Text('Confirmação'),
                          content: Text(
                            'Tem certeza que deseja cancelar o agendamento?',
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () => Get.back(),
                              child: Text('Não'),
                            ),
                            FlatButton(
                              onPressed: controller.deleteAgendamento,
                              child: Text('Sim'),
                            )
                          ],
                        ));
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ActionButton(
                      textButton: 'Finalizar',
                      colorButton: Colors.green,
                      action: controller.finalizarAgendamento,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
