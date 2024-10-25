import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/models/booking.dart';
import 'package:auto_ichi/models/meeting.dart';
import 'package:auto_ichi/screens/booking_screen.dart';
import 'package:auto_ichi/screens/profile_screen.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CalendarAppointmentsWidget extends StatelessWidget {
  const CalendarAppointmentsWidget(
      {super.key, required this.selectedDate, required this.meetings});
  final DateTime selectedDate;
  final List<dynamic> meetings;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        itemCount: meetings.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side:
                      BorderSide(color: meetings[index].background, width: 2)),
              tileColor: TColors.softGrey,
              title: Text(meetings[index].eventName),
              onTap: () {
                Meeting meeting = meetings[index];
                var bookingID = meeting.eventName.split(" ")[0];
                Booking? booking = Get.find<BookingsController>()
                    .bookings
                    .firstWhereOrNull((e) => e.id.toString() == bookingID);
                if (booking != null) {
                  Get.find<BookingsController>().selectedBooking(booking);
                  Get.to(() => const BookingScreen());
                }
              },
            ),
          );
        });
  }
}
