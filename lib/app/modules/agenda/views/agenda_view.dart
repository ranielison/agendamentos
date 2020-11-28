import 'package:agendamentos/app/modules/agenda/widgets/calendar.dart';
import 'package:agendamentos/app/modules/lista_servicos/views/lista_servicos_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaView extends GetView<AgendaController> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgendaView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Calendar(),
          const SizedBox(height: 10),
          SfCalendar(
            view: CalendarView.day,
            headerHeight: 0,
            dataSource: MeetingDataSource([
              Meeting(
                'Limpeza de pele',
                DateTime(today.year, today.month, today.day, 9, 0, 0),
                DateTime(today.year, today.month, today.day, 11, 0, 0),
                Colors.blue[300],
                false,
              ),
            ]),
            monthViewSettings: MonthViewSettings(
              agendaStyle: AgendaStyle(
                dateTextStyle: TextStyle(
                  color: Colors.red,
                ),
              ),
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            ),
            timeSlotViewSettings: TimeSlotViewSettings(
              startHour: 9,
              endHour: 16,
              timeInterval: Duration(minutes: 30),
              nonWorkingDays: <int>[DateTime.friday, DateTime.saturday],
            ),
            appointmentTextStyle: TextStyle(
              fontSize: 20,
            ),
            //appointmentTimeTextFormat: 'yyyy',
          )

          /*Expanded(
            child: Obx(
              () => ListaServicosView(
                agendamentos: controller.selectedEvents,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
