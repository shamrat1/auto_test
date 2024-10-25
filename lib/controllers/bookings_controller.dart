import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:auto_ichi/models/booking.dart';
import 'package:auto_ichi/models/meeting.dart';
import 'package:auto_ichi/models/user.dart';
import 'package:auto_ichi/repositories/booking_repository.dart';
import 'package:auto_ichi/screens/booking_edit_screen.dart';
import 'package:auto_ichi/screens/booking_screen.dart';
import 'package:auto_ichi/screens/calendar_screen.dart';
import 'package:auto_ichi/widgets/calendar_appointments_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingsController extends GetxController {
  CalendarController calendarController = CalendarController();
  Rx<CalendarView> calenderView = CalendarView.month.obs;
  Rx<DateTime?> currentStartDate = null.obs;
  Rx<DateTime?> currentEndDate = null.obs;
  BookingRepository _repository = BookingRepository();
  RxBool loading = false.obs;
  RxList<Booking> bookings = <Booking>[].obs;
  RxList<Meeting> myMeetings = <Meeting>[].obs;
  RxList<User> mechanics = <User>[].obs;
  Rx<int> selectedMechanicID = 0.obs;
  Rx<Booking> selectedBooking = Booking().obs;
  Rx<String> selectedStatus = "".obs;
  @override
  void onInit() {
    getBookings();
    if (Get.find<AuthenticationController>().isAdmin()) {
      getMechanics();
    }
    super.onInit();
  }

  void setMechanic(User m) {
    selectedMechanicID(m.id);
  }

  Future<void> getBookings({String? start, String? end}) async {
    loading(true);

    var response = await _repository.getBookings();
    response.fold((error) {
      Fluttertoast.showToast(msg: error);
    }, (values) {
      bookings.value = values;
      myMeetings.value = getDataSource();
    });
    loading(false);
  }

  void getMechanics() async {
    loading(true);
    var response = await _repository.getMechanics();

    response.fold((error) {
      Fluttertoast.showToast(msg: error);
    }, (values) {
      mechanics.value = values;
    });
    loading(false);
  }

  void updateBooking() async {
    if (selectedBooking.value.id == null) return;
    loading(true);
    var response = await _repository.updateBooking(selectedBooking.value.id!, {
      "status": selectedStatus.value,
      "mechanic_id": selectedMechanicID.value.toString(),
    });

    response.fold((error) {
      Fluttertoast.showToast(msg: error, backgroundColor: Colors.red);
    }, (values) {
      getBookings();
      Fluttertoast.showToast(
          msg: "Booking Updated.", backgroundColor: Colors.green);
      Get.back();
      Get.back();
    });
    loading(false);
  }

  void onTapDate(CalendarTapDetails details) {
    calendarController.selectedDate = details.date;
    if (details.appointments?.length == 1) {
      Meeting meeting = details.appointments?.first;
      var bookingID = meeting.eventName.split(" ")[0];
      Booking? booking =
          bookings.firstWhereOrNull((e) => e.id.toString() == bookingID);
      if (booking != null) {
        selectedBooking(booking);
        Get.to(() => const BookingScreen());
      }
    } else if ((details.appointments?.length ?? 0) > 1) {
      showModalBottomSheet(
          context: Get.context!,
          builder: (context) {
            return CalendarAppointmentsWidget(
              selectedDate: details.date!,
              meetings: details.appointments ?? [],
            );
          });
    }
  }

  void onTapEdit() {
    var mechanic = selectedBooking.value.mechanic;
    selectedMechanicID(mechanic?.id);
    Get.to(() => const BookingEditScreen());
  }

  List<Meeting> getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    for (var element in bookings) {
      if (element.startDatetime != null && element.endDatetime != null) {
        meetings.add(Meeting(
            "${element.id} ${element.bookingTitle}\n${element.mechanic?.name != null ? "For ${element.mechanic?.name}" : ''}\nCreated By ${element.admin?.name}",
            element.startDatetime!,
            element.endDatetime!,
            getBookingColor(element.status ?? ""),
            false));
      }
    }

    return meetings;
  }

  Color getBookingColor(String status) {
    switch (status) {
      case "pending":
        return Theme.of(Get.context!).primaryColor.withOpacity(.7);
      case "in-progress":
        return Colors.amber.withOpacity(.7);
      case "complete":
        return Colors.green;
      case "no-show":
        return Colors.grey.withOpacity(.7);
      case "cancelled":
        return Colors.red;
      default:
        return Theme.of(Get.context!).primaryColor.withOpacity(.7);
    }
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
      // currentStartDate(details.visibleDates.first);
      // currentEndDate(details.visibleDates.last);
      print(DateFormat("d-M-y hh:mm a").format(details.visibleDates.first));
      print(DateFormat("d-M-y hh:mm a").format(details.visibleDates.last));
      getBookings(
          start: DateFormat("d-M-y hh:mm a").format(details.visibleDates.first),
          end: DateFormat("d-M-y hh:mm a").format(details.visibleDates.last));
    }
  }
}
