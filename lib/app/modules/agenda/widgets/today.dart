import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  final int day;

  const Today({Key key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      color: Colors.amber[400],
      width: 100,
      height: 100,
      child: Text(
        '$day',
        style: TextStyle().copyWith(fontSize: 16.0),
      ),
    );
  }
}
