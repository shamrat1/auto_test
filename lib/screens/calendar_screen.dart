import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/models/meeting.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:auto_ichi/widgets/appointment_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({
    super.key,
  });
  final BookingsController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              "Bookings (${_controller.calenderView.value.name.capitalizeFirst})"),
        ),
        body: SfCalendar(
          view: _controller.calenderView.value,
          cellBorderColor: Theme.of(context).primaryColor.withOpacity(0.3),
          todayHighlightColor: Theme.of(context).primaryColor,
          dataSource: MeetingDataSource(_controller.getDataSource()),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          headerStyle: CalendarHeaderStyle(
            backgroundColor: TColors.primary.withOpacity(0.3).withAlpha(9),
          ),
          // appointmentBuilder: (context, calendarAppointmentDetails) =>
          //     GestureDetector(
          //   onTap: () =>
          //       _controller.onAppointmentTapped(calendarAppointmentDetails),
          //   child: AppointmentWidget(
          //       view: _controller.calenderView.value,
          //       calendarAppointmentDetails: calendarAppointmentDetails),
          // ),
          onTap: _controller.onTapDate,
          // onViewChanged: _controller.onViewChanged,
        ),
      );
    });
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
