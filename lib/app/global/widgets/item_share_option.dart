import 'package:agendamentos/app/data/models/item_share_option_model.dart';
import 'package:flutter/material.dart';

class ItemShareOption extends StatelessWidget {
  final ItemShareOptionModel item;

  const ItemShareOption({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.name,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        )
      ],
    );
  }
}
