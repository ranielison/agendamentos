import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/widgets/geral_button.dart';
import 'package:agendamentos/app/modules/criar_agendamento/widgets/item_servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/criar_agendamento/controllers/criar_agendamento_controller.dart';

class CriarAgendamentoView extends GetView<CriarAgendamentoController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo agendamento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '06/12/2020 às 9:00h',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primary,
              ),
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
                      validator: (value) {
                        if (value.isEmpty) return '* Obrigatório';
                        return null;
                      },
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
                      validator: (value) {
                        if (value.isEmpty) return '* Obrigatório';
                        return null;
                      },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isRetorno,
                    onChanged: controller.toogleCheckboxRetorno,
                  ),
                ),
                Text(
                  'É retorno',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                'Serviços',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: 16,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 4,
                  child: DropdownButtonFormField<Servico>(
                    hint: Text('Insurance Category'),
                    items: controller.servicos.map((item) {
                      return new DropdownMenuItem<Servico>(
                        child: new Text(item.description),
                        value: item,
                      );
                    }).toList(),
                    onChanged: controller.setServiceSelected,
                    value: controller.servicoSelected,
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: controller.addServico,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            GeralButton(
              textButton: 'Agendar',
              action: () {
                if (_formKey.currentState.validate()) {
                  controller.criarAgendamento();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
