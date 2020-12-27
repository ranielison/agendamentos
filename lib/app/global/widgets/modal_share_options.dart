import 'package:agendamentos/app/global/widgets/item_share_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_options/share_options.dart';

class ModalShareOptions extends StatelessWidget {
  final List<ShareOption> listaOptions;

  const ModalShareOptions({Key key, this.listaOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 3,
            width: 30,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 15),
          ),
          Text(
            'Compartilhar com...',
            style: TextStyle(
              color: Get.theme.primaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: listaOptions
                  .map(
                    (op) => ItemShareOption(item: op),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
