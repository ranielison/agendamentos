import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final Function action;

  const HomeButton({
    Key key,
    @required this.title,
    @required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Constants.pink,
              Constants.primary,
            ],
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
