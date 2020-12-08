import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();

  Hive..init(appDocDir.path);
  //..registerAdapter(adapter)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  initializeDateFormatting().then(
    (_) => runApp(
      GetMaterialApp(
        title: "Application",
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          primaryColor: Constants.primary,
        ),
      ),
    ),
  );
}
