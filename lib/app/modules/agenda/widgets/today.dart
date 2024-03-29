import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  final int day;
  final bool disponivel;
  final bool aberto;

  const Today({
    Key key,
    this.day,
    this.disponivel,
    this.aberto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      //padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.amber[400],
        ),
      ),
      width: 100,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$day',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
          Container(
            height: 2,
            width: 15,
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: !aberto
                  ? Colors.grey[800]
                  : disponivel
                      ? Colors.green
                      : Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
