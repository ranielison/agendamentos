import 'package:agendamentos/app/data/models/item_share_option_model.dart';
import 'package:agendamentos/app/global/widgets/item_share_option.dart';
import 'package:flutter/material.dart';

class ModalShareOptions extends StatelessWidget {
  final List<ItemShareOptionModel> listaOptions;

  const ModalShareOptions({Key key, this.listaOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: ListView.builder(
        itemCount: listaOptions.length,
        itemBuilder: (_, index) {
          final item = listaOptions[index];

          return ItemShareOption(item: item);
        },
      ),
    );
  }
}
