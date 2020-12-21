import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/details/controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => controller.deleteAgendamento(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Detalhes',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
