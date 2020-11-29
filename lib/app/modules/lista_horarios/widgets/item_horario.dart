import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemHorario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Constants.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:00h - 9:30h',
            style: TextStyle(
              color: Constants.grey,
              fontSize: 16,
            ),
          ),
          Text(
            'Livre',
            style: TextStyle(
              color: Constants.green,
            ),
          ),
        ],
      ),
    );
  }
}
