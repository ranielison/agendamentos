import 'package:agendamentos/app/modules/settings/widgets/horario_comercial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Definições'),
        actions: [
          Obx(
            () => Visibility(
              visible: controller.needSave,
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: controller.saveData,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  'Intervalo entre horários',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Obx(
                  () => DropdownButton(
                    value: controller.intervalSelected.value,
                    items: <int>[15, 30]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text('$e Minutos'),
                          ),
                        )
                        .toList(),
                    onChanged: (item) {
                      print(item);
                      controller.intervalSelected.value = item;
                      controller.setNeedSave(true);
                    },
                  ),
                ),
              ],
            ),
          ),
          HorarioComercial(),
        ],
      ),
    );
  }
}
