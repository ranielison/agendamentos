import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/modules/lista_servicos/widgets/item_agendamento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/lista_servicos/controllers/lista_servicos_controller.dart';

class ListaServicosView extends GetView<ListaServicosController> {
  final List agendamentos;

  ListaServicosView({this.agendamentos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (_, index) {
          Agendamento ag = agendamentos[index];

          return ItemAgendamento(
            agendamento: ag,
          );
        },
      ),
    );
  }
}
