import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/widgets/geral_button.dart';
import 'package:agendamentos/app/modules/criar_agendamento/controllers/criar_agendamento_controller.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:agendamentos/app/utils/no_animation_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogServicos extends StatelessWidget {
  final _controller = Get.find<CriarAgendamentoController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Serviços',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: Get.height * .4,
        child: Column(
          children: [
            Expanded(
              child: _controller.servicos.isNotEmpty
                  ? NoAnimationList(
                      child: ListView.builder(
                        itemCount: _controller.servicos.length,
                        itemBuilder: (_, i) {
                          Servico servico = _controller.servicos[i];

                          return ListTile(
                            title: Text(
                              servico.description,
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text('Duração: ',
                                    style: TextStyle(color: Colors.grey)),
                                SizedBox(width: 3),
                                Text(
                                  Constants.hformat.format(
                                    DateTime(2020).add(
                                      Duration(
                                          minutes: servico.durationInMinutes),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Obx(
                              () => IconButton(
                                icon: _controller.servicosSelecionados
                                        .contains(servico)
                                    ? Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.add,
                                        color: Get.theme.primaryColor,
                                      ),
                                onPressed: () {
                                  if (_controller.servicosSelecionados
                                      .contains(servico)) {
                                    _controller.removeServico(servico);
                                  } else {
                                    _controller.addServico(servico);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'Sem agendamentos cadastrados',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
            GeralButton(textButton: 'Ok', action: () => Get.back()),
          ],
        ),
      ),
    );
  }
}
