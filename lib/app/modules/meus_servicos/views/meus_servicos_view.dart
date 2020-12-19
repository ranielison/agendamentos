import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/modules/meus_servicos/widgets/dialog_novo_servico.dart';
import 'package:agendamentos/app/modules/meus_servicos/widgets/item_meu_servico.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/meus_servicos/controllers/meus_servicos_controller.dart';

class MeusServicosView extends GetView<MeusServicosController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus serviços'),
      ),
      body: controller.servicos.isNotEmpty
          ? Obx(
              () => ListView.builder(
                itemCount: controller.servicos.length,
                itemBuilder: (_, index) {
                  Servico item = controller.servicos[index];

                  return ItemMeuServico(
                    servico: item,
                  );
                },
              ),
            )
          : Center(
              child: Text(
                'Não há serviços cadastrados',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () {
          controller.resetFields();
          Get.dialog(DialogNovoServico());
        },
      ),
    );
  }
}
