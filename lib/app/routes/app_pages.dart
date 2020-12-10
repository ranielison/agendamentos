import 'package:agendamentos/app/modules/details/views/details_view.dart';
import 'package:agendamentos/app/modules/details/bindings/details_binding.dart';
import 'package:agendamentos/app/modules/settings/views/settings_view.dart';
import 'package:agendamentos/app/modules/settings/bindings/settings_binding.dart';
import 'package:agendamentos/app/modules/criar_agendamento/views/criar_agendamento_view.dart';
import 'package:agendamentos/app/modules/criar_agendamento/bindings/criar_agendamento_binding.dart';
import 'package:agendamentos/app/modules/lista_horarios/bindings/lista_horarios_binding.dart';
import 'package:agendamentos/app/modules/lista_horarios/views/lista_horarios_view.dart';
import 'package:agendamentos/app/modules/agenda/views/agenda_view.dart';
import 'package:agendamentos/app/modules/agenda/bindings/agenda_binding.dart';
import 'package:agendamentos/app/modules/home/views/home_view.dart';
import 'package:agendamentos/app/modules/home/bindings/home_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.AGENDA,
      page: () => AgendaView(),
      binding: AgendaBinding(),
    ),
    GetPage(
      name: Routes.LISTA_HORARIOS,
      page: () => ListaHorariosView(),
      binding: ListaHorariosBinding(),
    ),
    GetPage(
      name: Routes.CRIAR_AGENDAMENTO, 
      page:()=> CriarAgendamentoView(), 
      binding: CriarAgendamentoBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS, 
      page:()=> SettingsView(), 
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.DETAILS, 
      page:()=> DetailsView(), 
      binding: DetailsBinding(),
    ),
  ];
}

class ListaServicosBinding {
}