import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Color colorButton;
  final String textButton;
  final Function action;

  const ActionButton({
    Key key,
    @required this.colorButton,
    @required this.textButton,
    @required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          textButton,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
