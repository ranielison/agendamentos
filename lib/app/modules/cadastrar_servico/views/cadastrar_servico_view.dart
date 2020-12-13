import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:agendamentos/app/modules/cadastrar_servico/controllers/cadastrar_servico_controller.dart';

class CadastrarServicoView extends GetView<CadastrarServicoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CadastrarServicoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CadastrarServicoView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  