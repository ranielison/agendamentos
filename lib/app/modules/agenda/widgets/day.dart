import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  final int day;
  final bool disponivel;

  const Day({
    Key key,
    this.day,
    this.disponivel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      decoration: BoxDecoration(
        color: disponivel ? Colors.transparent : Colors.red,
      ),
      width: 100,
      height: 100,
      child: Text(
        '$day',
        style: TextStyle().copyWith(fontSize: 16.0),
      ),
    );
  }
}
