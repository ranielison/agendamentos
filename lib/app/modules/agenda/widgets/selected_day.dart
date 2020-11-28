import 'package:flutter/material.dart';

class SelectedDay extends StatelessWidget {
  final AnimationController animationController;
  final int day;
  final bool disponivel;

  const SelectedDay({
    Key key,
    this.animationController,
    this.day,
    this.disponivel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        animationController,
      ),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.only(top: 5.0, left: 6.0),
        color: Colors.deepOrange[400],
        width: 100,
        height: 100,
        child: Text(
          '$day',
          style: TextStyle().copyWith(fontSize: 16.0),
        ),
      ),
    );
  }
}
