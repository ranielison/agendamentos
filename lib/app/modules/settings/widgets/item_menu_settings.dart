import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMenuSettings extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color colorIcon;

  const ItemMenuSettings({
    Key key,
    this.label,
    this.icon,
    this.colorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: colorIcon ?? Get.theme.primaryColor,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
