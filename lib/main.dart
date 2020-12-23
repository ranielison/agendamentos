import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/data/models/agendamento.dart';
import 'app/data/models/cliente.dart';
import 'app/data/models/expediente.dart';
import 'app/data/models/expediente_settings.dart';
import 'app/data/models/horario.dart';
import 'app/data/models/servico.dart';
import 'app/global/bindings/applicationBinding.dart';
import 'app/routes/app_pages.dart';

//TODO: Criar funcionalidade de exportar/importar json com os dados salvos
//TODO: Criar tela de detalhes do agendamento

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocDir.path)
    ..registerAdapter(AgendamentoAdapter())
    ..registerAdapter(ClienteAdapter())
    ..registerAdapter(ExpedienteSettingsAdapter())
    ..registerAdapter(ExpedienteDayAdapter())
    ..registerAdapter(HorarioAdapter())
    ..registerAdapter(ServicoAdapter());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Get.put<SharedPreferences>(await SharedPreferences.getInstance());

  initializeDateFormatting().then(
    (_) => runApp(
      GetMaterialApp(
        title: "Application",
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: ApplicationBinding(),
        theme: ThemeData(
          primaryColor: Constants.primary,
        ),
      ),
    ),
  );
}
