import 'package:agendamentos/app/global/controllers/global_controller.dart';
import 'package:agendamentos/app/modules/settings/widgets/horario_comercial.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final _globalController = Get.find<GlobalController>();

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
          ),
        ],
      ),
      body: Column(
        children: [
          HorarioComercial(),
          Divider(),
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
          Divider(),
          InkWell(
            onTap: () => Get.toNamed(Routes.MEUS_SERVICOS),
            child: Card(
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      'Meus serviços',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      color: Get.theme.primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Obx(
              () => Row(
                children: [
                  Text(
                    'Contador de agendamentos',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Checkbox(
                    value: _globalController.showEventAmount,
                    activeColor: Get.theme.primaryColor,
                    onChanged: _globalController.setShowEventAmount,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: controller.createbackup,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 25,
              ),
              child: Row(
                children: [
                  Text(
                    'Criar backup',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.backup,
                    color: Get.theme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: controller.restoreJsonDataBackup,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 25,
              ),
              child: Row(
                children: [
                  Text(
                    'Restaurar backup',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.restore,
                    color: Get.theme.primaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
