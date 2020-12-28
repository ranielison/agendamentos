import 'package:agendamentos/app/global/controllers/global_controller.dart';
import 'package:agendamentos/app/global/widgets/dialog_aviso.dart';
import 'package:agendamentos/app/modules/settings/widgets/horario_comercial.dart';
import 'package:agendamentos/app/modules/settings/widgets/item_menu_settings.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final _globalController = Get.find<GlobalController>();

  Future<bool> _onWillPop() async {
    if (controller.needSave) {
      Get.dialog(
        DialogAviso(
          content: 'Deseja sair sem salvar?',
          action: () => Get.until((route) => Get.currentRoute == Routes.HOME),
        ),
      );
    } else {
      Get.back();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
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
                child: Obx(
                  () => ItemMenuSettings(
                    label: 'Exportar dados',
                    icon: controller.loadingExport
                        ? Icons.hourglass_empty
                        : Icons.cloud_upload,
                    colorIcon: controller.loadingExport ? Colors.grey : null,
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () => Get.dialog(
                  AlertDialog(
                    title: Text('Aviso', textAlign: TextAlign.center),
                    content: Text(
                        'Os dados existentes serão totalmente sobrescritos pelos dados importados, deseja continuar?'),
                    actions: [
                      FlatButton(
                        onPressed: () => Get.back(),
                        child: Text('Não'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Get.back();
                          controller.restoreJsonDataBackup();
                        },
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                ),
                child: ItemMenuSettings(
                  label: 'Importar dados',
                  icon: Icons.cloud_download,
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () => Get.dialog(
                  AlertDialog(
                    title: Text('Desenvolvido por'),
                    content: Text('Raniélison Soares'),
                    actions: [
                      FlatButton(
                        onPressed: () => Get.back(),
                        child: Text('Fechar'),
                      ),
                    ],
                  ),
                ),
                child: ItemMenuSettings(
                  label: 'Sobre',
                  icon: Icons.info,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
