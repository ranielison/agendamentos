import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/modules/details/widgets/item_servico_card.dart';
import 'package:flutter/material.dart';

class CardServicos extends StatelessWidget {
  final List<Servico> servicos;

  const CardServicos({Key key, this.servicos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Serviços',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ...servicos.map(
              (s) => ItemServicoCard(servico: s),
            )
          ],
        ),
      ),
    );
  }
}
