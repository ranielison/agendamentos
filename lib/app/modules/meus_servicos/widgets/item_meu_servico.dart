import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemMeuServico extends StatelessWidget {
  final Servico servico;

  const ItemMeuServico({
    Key key,
    this.servico,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Limpeza de pele'),
      subtitle: Row(
        children: [
          Text('Duração: ', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 3),
          Text(
            Constants.hformat.format(
              DateTime(2020).add(
                Duration(minutes: 45),
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
            value: 'Lion',
          ),
        ],
        onSelected: (value) {},
      ),
    );
  }
}
