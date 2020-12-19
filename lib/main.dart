import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'app/data/models/agendamento.dart';
import 'app/data/models/cliente.dart';
import 'app/data/models/expediente.dart';
import 'app/data/models/expediente_settings.dart';
import 'app/data/models/horario.dart';
import 'app/data/models/servico.dart';
import 'app/global/bindings/applicationBinding.dart';
import 'app/routes/app_pages.dart';

//TODO: Excluir agendamento
//TODO: Não permitir que o agendamento ultrapasse do horario do expediente/turno
//TODO: Exibir a duração total antes de agendar
//TODO: Resolver problema na primeira vez que abre o app quando as definições ainda não foram configuradas
//TODO: Criar funcionalidade de exportar/importar json com os dados salvos
//TODO: Criar tela de detalhes do agendamento
//TODO: Atualizar lista de agendamentos do dia assim que abre a agenda
//TODO: Permitir que o usuario exiba ou oculte o numero de agendamentos do dia no calendario

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
