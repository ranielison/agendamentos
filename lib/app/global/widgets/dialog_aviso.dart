import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAviso extends StatelessWidget {
  final String title;
  final String content;
  final Function action;

  const DialogAviso({
    Key key,
    this.title,
    this.content,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'Aviso', textAlign: TextAlign.center),
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
