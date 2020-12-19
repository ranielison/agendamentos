import 'package:agendamentos/app/global/widgets/geral_button.dart';
import 'package:agendamentos/app/modules/meus_servicos/controllers/meus_servicos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DialogNovoServico extends StatelessWidget {
  final controller = Get.find<MeusServicosController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Novo serviço',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    cursorColor: Get.theme.primaryColor,
                    onChanged: controller.setServicoField,
                    validator: (value) {
                      if (value.isEmpty) return '* Obrigatório';
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Serviço',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Nome do serviço',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    cursorColor: Get.theme.primaryColor,
                    onChanged: controller.setDurationField,
                    validator: (value) {
                      if (value.isEmpty) return '* Obrigatório';
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Duração',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'mm',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      //prefixIcon: Icon(Icons.timelapse),
                      suffix: Text(
                        'Minutos',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GeralButton(
              textButton: 'Adicionar',
              action: controller.addServico,
            ),
          )
        ],
      ),
    );
  }
}
