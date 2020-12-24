import 'package:agendamentos/app/global/widgets/geral_button.dart';
import 'package:agendamentos/app/modules/criar_agendamento/widgets/dialog_servicos.dart';
import 'package:agendamentos/app/modules/criar_agendamento/widgets/item_servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/criar_agendamento/controllers/criar_agendamento_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CriarAgendamentoView extends GetView<CriarAgendamentoController> {
  final _formKey = GlobalKey<FormState>();

  final maskPhoneFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo agendamento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, color: Get.theme.primaryColor),
                  SizedBox(width: 3),
                  Text(
                    Constants.dhformat.format(controller.dataAgendamento),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        cursorColor: Constants.primary,
                        onChanged: controller.setClientField,
                        focusNode: controller.focusCliente,
                        validator: (value) {
                          if (value.isEmpty) return '* Obrigatório';
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        onFieldSubmitted: (_) {
                          controller.focusCliente.unfocus();
                          FocusScope.of(context).requestFocus(
                            controller.focusContato,
                          );
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Cliente',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Nome do cliente',
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
                        cursorColor: Constants.primary,
                        keyboardType: TextInputType.number,
                        onChanged: controller.setContatoField,
                        focusNode: controller.focusContato,
                        validator: (value) {
                          if (value.length > 0 && value.length < 15)
                            return '* Incompleto';
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          controller.focusContato.unfocus();
                          Get.dialog(DialogServicos());
                        },
                        textInputAction: TextInputAction.next,
                        inputFormatters: [maskPhoneFormatter],
                        decoration: InputDecoration(
                          labelText: 'Contato',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: '(00) 00000-0000',
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text(
                  'Serviços',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
              Obx(
                () => Column(
                  children: controller.servicosSelecionados
                      .map(
                        (s) => ItemServico(
                          servico: s,
                        ),
                      )
                      .toList(),
                ),
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.dialog(DialogServicos());
                },
                child: Card(
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.grey),
                        Text(
                          'Adicionar serviço',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Obx(
                  () => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Duração total: ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            Constants.hformat.format(
                              DateTime(2020).add(
                                controller.durationPreenchida.value,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      GeralButton(
                        textButton: 'Agendar',
                        enabled: controller.servicosSelecionados.isNotEmpty &&
                            controller.durationPermitida,
                        action: () {
                          if (_formKey.currentState.validate()) {
                            controller.criarAgendamento();
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: !controller.durationPermitida,
                        child: Text(
                          '* Duração excede o limite disponível',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
