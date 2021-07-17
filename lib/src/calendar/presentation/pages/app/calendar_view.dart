import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vet_app/src/calendar/domain/calendar_controller.dart';
import 'calendar/calendar_event_view.dart';

class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      builder: (_) {
        return CalendarEventView();
      },
    );
  }
}
