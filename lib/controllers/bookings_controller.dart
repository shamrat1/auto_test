import 'package:auto_ichi/models/booking.dart';
import 'package:auto_ichi/models/meeting.dart';
import 'package:auto_ichi/repositories/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingsController extends GetxController {
  CalendarController calendarController = CalendarController();
  Rx<CalendarView> calenderView = CalendarView.month.obs;
  Rx<DateTime?> currentStartDate = null.obs;
  Rx<DateTime?> currentEndDate = null.obs;
  BookingRepository _repository = BookingRepository();
  RxBool loading = false.obs;
  RxList<Booking> bookings = <Booking>[].obs;

  @override
  void onInit() {
    getBookings();
    super.onInit();
  }

  void getBookings() async {
    loading(true);
    var response = await _repository.getBookings();
    response.fold((error) {
      Fluttertoast.showToast(msg: error);
    }, (values) {
      bookings.value = values;
    });
    loading(false);
  }

  void onTapDate(CalendarTapDetails details) {
    print(details.appointments);
    calendarController.selectedDate = details.date;
  }

  List<Meeting> getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    for (var element in bookings) {
      if (element.startDatetime != null && element.endDatetime != null) {
        meetings.add(Meeting(
            "${element.id} ${element.bookingTitle}\n${element.mechanic?.name != null ? "For ${element.mechanic?.name}" : ''}\nCreated By ${element.admin?.name}",
            element.startDatetime!,
            element.endDatetime!,
            Theme.of(Get.context!).primaryColor.withOpacity(.7),
            false));
      }
    }

    return meetings;
  }

  void setView(CalendarView view) {
    calenderView(view);
  }

  void onAppointmentTapped(CalendarAppointmentDetails details) {
    print(details.appointments.first);
  }

  void onViewChanged(ViewChangedDetails details) {
    if (currentStartDate.value != details.visibleDates.first &&
        currentEndDate.value != details.visibleDates.last) {
      currentStartDate(details.visibleDates.first);
      currentEndDate(details.visibleDates.last);
    }
  }
}
