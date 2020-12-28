import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/widgets/dialog_aviso.dart';
import 'package:agendamentos/app/modules/meus_servicos/controllers/meus_servicos_controller.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMeuServico extends StatelessWidget {
  final Servico servico;

  ItemMeuServico({
    Key key,
    this.servico,
  }) : super(key: key);

  final controller = Get.find<MeusServicosController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(servico.description),
      subtitle: Row(
        children: [
          Text('Duração: ', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 3),
          Text(
            Constants.hformat.format(
              DateTime(2020).add(
                Duration(minutes: servico.durationInMinutes),
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (_) => <PopupMenuItem<String>>[
          new PopupMenuItem<String>(
            child: const Text('Editar'),
            value: 'Editar',
          ),
          new PopupMenuItem<String>(
            child: const Text('Excluir'),
            value: 'Excluir',
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 'Editar':
              controller.openDialogEdit(servico);
              break;
            case 'Excluir':
              Get.dialog(DialogAviso(
                content: 'Deseja realmente excluir este serviço?',
                action: () => controller.excluirServico(servico.id),
              ));
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
