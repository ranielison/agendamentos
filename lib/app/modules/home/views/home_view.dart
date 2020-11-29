import 'package:agendamentos/app/modules/home/widgets/home_button.dart';
import 'package:agendamentos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.asset('assets/logo.jpeg'),
          ),
          HomeButton(
            title: 'Minha Agenda',
            action: () => Get.toNamed(Routes.AGENDA),
          ),
          HomeButton(
            title: 'Definições',
            action: () {},
          ),
        ],
      ),
    );
  }
}
