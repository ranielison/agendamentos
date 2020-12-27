import 'package:flutter/material.dart';
import 'package:share_options/share_options.dart';

class ItemShareOption extends StatelessWidget {
  final ShareOption item;

  const ItemShareOption({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => item.share(),
      child: Card(
        elevation: 5,
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.memory(item.icon),
              ),
              SizedBox(height: 5),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
