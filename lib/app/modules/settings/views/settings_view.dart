import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsView'),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: controller.limparDados,
          child: Text(
            'Limpar dados',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
