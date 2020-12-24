import 'package:agendamentos/app/global/controllers/global_controller.dart';
import 'package:agendamentos/app/modules/agenda/controllers/agenda_controller.dart';
import 'package:agendamentos/app/modules/agenda/widgets/day.dart';
import 'package:agendamentos/app/modules/agenda/widgets/event_marker.dart';
import 'package:agendamentos/app/modules/agenda/widgets/selected_day.dart';
import 'package:agendamentos/app/modules/agenda/widgets/today.dart';
import 'package:agendamentos/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final controller = Get.find<AgendaController>();
  final _globalController = Get.find<GlobalController>();

  final DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'pt_BR',
      calendarController: controller.calendarController,
      events: controller.events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.red[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.red[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.red[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return Obx(
            () => Day(
              day: date.day,
              aberto: controller.dayIsOpen(date),
              isPast: date.compareTo(today) < 0,
              disponivel:
                  controller.disponibilidade[Constants.dformat.format(date)] ??
                      true,
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return SelectedDay(
            animationController: controller.animationController,
            day: date.day,
            aberto: controller.dayIsOpen(date),
            disponivel:
                controller.disponibilidade[Constants.dformat.format(date)] ??
                    true,
          );
        },
        todayDayBuilder: (context, date, _) {
          return Today(
            day: date.day,
            aberto: controller.dayIsOpen(date),
            disponivel:
                controller.disponibilidade[Constants.dformat.format(date)] ??
                    true,
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: Obx(
                  () => EventMarker(
                    calendarController: controller.calendarController,
                    date: date,
                    isPast: date.compareTo(today) < 0,
                    amount: controller.events[date]?.length ?? 0,
                    visible: _globalController.showEventAmount,
                  ),
                ),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: Icon(
                  Icons.add_box,
                  size: 20.0,
                  color: Colors.blueGrey[800],
                ),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        controller.onDaySelected(date, events, holidays);
        controller.animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: controller.onVisibleDaysChanged,
      onCalendarCreated: controller.onCalendarCreated,
    );
  }
}
