import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogConfirmacao extends StatelessWidget {
  final String content;
  final Function action;

  const DialogConfirmacao({
    Key key,
    this.content,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmação', textAlign: TextAlign.center),
      content: Text(content),
      actions: [
        FlatButton(
          onPressed: () => Get.back(),
          child: Text('Não'),
        ),
        FlatButton(
          onPressed: action,
          child: Text('Sim'),
        ),
      ],
    );
  }
}
