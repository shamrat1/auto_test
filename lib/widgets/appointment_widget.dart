import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget(
      {super.key,
      required this.view,
      required this.calendarAppointmentDetails});
  final CalendarView view;
  final CalendarAppointmentDetails calendarAppointmentDetails;
  @override
  Widget build(BuildContext context) {
    if (calendarAppointmentDetails.isMoreAppointmentRegion) {
      return Container(
        width: calendarAppointmentDetails.bounds.width,
        height: calendarAppointmentDetails.bounds.height,
        child: Text('+More'),
      );
    } else if (view == CalendarView.month) {
      final Appointment appointment =
          calendarAppointmentDetails.appointments.first;
      return Container(
          decoration: BoxDecoration(
              color: appointment.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.cyan],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft)),
          alignment: Alignment.center,
          child: appointment.isAllDay
              ? Text('${appointment.subject}',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 10))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${appointment.subject}',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                    Text(
                        '${DateFormat('hh:mm a').format(appointment.startTime)} - ' +
                            '${DateFormat('hh:mm a').format(appointment.endTime)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 10))
                  ],
                ));
    } else {
      final Appointment appointment =
          calendarAppointmentDetails.appointments.first;
      return Container(
        width: calendarAppointmentDetails.bounds.width,
        height: calendarAppointmentDetails.bounds.height,
        child: Text(appointment.subject),
      );
    }
  }
}
