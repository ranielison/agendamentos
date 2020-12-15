import 'package:agendamentos/app/modules/settings/controllers/settings_controller.dart';
import 'package:agendamentos/app/modules/settings/widgets/item_horario_expediente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorarioComercial extends StatelessWidget {
  final controller = Get.find<SettingsController>();

  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Horário comercial',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Dia',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ...mapIndexed(
                    weekDays,
                    (index, item) => InkWell(
                      onTap: () => controller.toggleActiveDay(index),
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            item,
                            style: TextStyle(
                              color: controller.activeDays[index] ?? false
                                  ? Get.theme.primaryColor
                                  : Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).toList(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Horário',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ...mapIndexed(
                    controller.inicioHorarios,
                    (index, item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => ItemHorarioExpediente(
                              horario: controller.inicioHorarios[index],
                              //interval: controller.intervalSelected.value,
                              active: controller.activeDays[index],
                              colorItem: Get.theme.primaryColor,
                              onSelect: (horario) {
                                print(horario.format(context));
                                controller.setHorarioInicio(
                                  index,
                                  horario,
                                );
                              },
                            ),
                          ),
                          Text(
                            ' - ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Obx(
                            () => ItemHorarioExpediente(
                              horario: controller.fimHorarios[index],
                              //interval: controller.intervalSelected.value,
                              active: controller.activeDays[index],
                              colorItem: Get.theme.primaryColor,
                              onSelect: (horario) {
                                print(horario.format(context));
                                controller.setHorarioFim(
                                  index,
                                  horario,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pausa',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ...mapIndexed(
                    controller.inicioHorarios,
                    (index, item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => ItemHorarioExpediente(
                              horario: controller.pausaHorarios[index],
                              //interval: controller.intervalSelected.value,
                              active: controller.activeDays[index],
                              colorItem: Colors.grey,
                              onSelect: (horario) {
                                print(horario.format(context));
                                controller.setHorarioPausa(
                                  index,
                                  horario,
                                );
                              },
                            ),
                          ),
                          Text(' - ', style: TextStyle(color: Colors.grey)),
                          Obx(
                            () => ItemHorarioExpediente(
                              horario: controller.retornoHorarios[index],
                              //interval: controller.intervalSelected.value,
                              active: controller.activeDays[index],
                              colorItem: Colors.grey,
                              onSelect: (horario) {
                                print(horario.format(context));
                                controller.setHorarioRetorno(
                                  index,
                                  horario,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
