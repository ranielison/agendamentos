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
          GestureDetector(
            onTap: controller.createbackup,
            child: Container(
              constraints: BoxConstraints(
                minHeight: 30,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 25,
                ),
                child: Row(
                  children: [
                    Text(
                      'Exportar dados',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => Visibility(
                        visible: !controller.loadingExport,
                        child: Icon(
                          Icons.backup,
                          color: Get.theme.primaryColor,
                        ),
                        replacement: Icon(
                          Icons.hourglass_empty,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: controller.restoreJsonDataBackup,
            child: Container(
              constraints: BoxConstraints(
                minHeight: 30,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 25,
                ),
                child: Row(
                  children: [
                    Text(
                      'Importar dados',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.cloud_download,
                      color: Get.theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
