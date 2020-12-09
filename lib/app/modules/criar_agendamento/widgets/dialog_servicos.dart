import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/modules/criar_agendamento/controllers/criar_agendamento_controller.dart';
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
              subtitle: Text(
                '45:00 | R\$25,00',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: Obx(
                () => IconButton(
                  icon: _controller.servicosSelecionados.contains(servico)
                      ? Icon(
                          Icons.remove,
                          color: Colors.grey,
                        )
                      : Icon(
                          Icons.add,
                          color: Get.theme.primaryColor,
                        ),
                  onPressed: () {
                    if (_controller.servicosSelecionados.contains(servico)) {
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
      ),
    );
  }
}
