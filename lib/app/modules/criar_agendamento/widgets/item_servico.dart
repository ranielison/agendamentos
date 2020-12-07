import 'package:flutter/material.dart';

class ItemServico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(),
              child: Text(
                'Limpeza de pele',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'R\$ 39,00',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
