import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/modules/settings/widgets/horario_comercial.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final _localDataHelper = Get.find<LocalDataHelper>();
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
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => _localDataHelper.limpaGeral(),
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
          )
        ],
      ),
    );
  }
}
