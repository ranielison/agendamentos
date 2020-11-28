import 'package:agendamentos/app/modules/lista_servicos/views/lista_servicos_view.dart';
import 'package:agendamentos/app/modules/lista_servicos/bindings/lista_servicos_binding.dart';
import 'package:agendamentos/app/modules/agenda/views/agenda_view.dart';
import 'package:agendamentos/app/modules/agenda/bindings/agenda_binding.dart';
import 'package:agendamentos/app/modules/home/views/home_view.dart';
import 'package:agendamentos/app/modules/home/bindings/home_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.AGENDA;

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
      name: Routes.LISTA_SERVICOS,
      page: () => ListaServicosView(),
      binding: ListaServicosBinding(),
    ),
  ];
}
