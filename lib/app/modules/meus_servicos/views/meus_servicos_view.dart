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
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (_, index) {
          return ItemMeuServico();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () => Get.dialog(DialogNovoServico()),
      ),
    );
  }
}
