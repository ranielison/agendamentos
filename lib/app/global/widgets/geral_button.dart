import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeralButton extends StatelessWidget {
  final String textButton;
  final Function action;
  final bool loading;
  final bool enabled;

  const GeralButton({
    Key key,
    @required this.textButton,
    @required this.action,
    this.loading = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? action : null,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? Get.theme.primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Visibility(
          visible: !loading,
          child: Text(
            textButton,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          replacement: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
