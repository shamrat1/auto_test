import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateBookingController extends GetxController {
  final TextEditingController carManufacturerController =
      TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carModelYearController = TextEditingController();
  final TextEditingController bookingInfoController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController registrationNoController =
      TextEditingController();
  Rx<DateTime> selectedStartTime = DateTime.now().obs;
  Rx<DateTime> selectedEndTime = DateTime.now().obs;
  RxBool loading = false.obs;
  RxInt selectedMechanicID = 0.obs;
  RxString carManufacturerError = "".obs;
  RxString carModelError = "".obs;
  RxString carYearError = "".obs;
  RxString registrationNoError = "".obs;
  RxString bookingInfoError = "".obs;
  RxString startTimeError = "".obs;
  RxString endTimeError = "".obs;
  RxString mechanicIDError = "".obs;
  RxString customerNameError = "".obs;
  RxString customerEmailError = "".obs;
  RxString customerPhoneError = "".obs;
  BookingRepository _repository = BookingRepository();

  void showDateTimeSelector([bool start = true]) async {
    var selectedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)));

    var selectedTime = await showTimePicker(
        context: Get.context!, initialTime: TimeOfDay.now());
    if (start) {
      selectedStartTime(DateTime(
        selectedDate!.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime!.hour,
        selectedTime.minute,
      ));
    } else {
      selectedEndTime(DateTime(
        selectedDate!.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime!.hour,
        selectedTime.minute,
      ));
    }
  }

  void login() async {
    if (_validate()) {
      loading(true);
      var data = {
        "car_make": carManufacturerController.text,
        "car_model": carModelController.text,
        "car_year": carModelYearController.text,
        "registration_plate": registrationNoController.text,
        "customer_name": customerNameController.text,
        "customer_phone": customerPhoneController.text,
        "customer_email": customerEmailController.text,
        "booking_title": bookingInfoController.text,
        "start_datetime":
            DateFormat("d-M-y hh:mm a").format(selectedStartTime.value),
        "end_datetime":
            DateFormat("d-M-y hh:mm a").format(selectedEndTime.value),
        "mechanic_id": selectedMechanicID.value.toString(),
      };
      var res = await _repository.createBooking(data);
      res.fold((err) {
        Fluttertoast.showToast(msg: err, backgroundColor: Colors.red);
      }, (res) {
        Get.find<BookingsController>().getBookings();

        Fluttertoast.showToast(msg: "New Booking Created.");
        Get.back();
      });
      loading(false);
    }
  }

  bool _validate() {
    if (carManufacturerController.text == "") {
      carManufacturerError.value = "Car Manufacturer is required";
    } else {
      carManufacturerError.value = "";
    }
    if (carModelController.text == "") {
      carModelError.value = "Car Model is required";
    } else {
      carModelError.value = "";
    }
    if (carModelYearController.text == "") {
      carYearError.value = "Car Year is required";
    } else {
      carYearError.value = "";
    }
    if (registrationNoController.text == "") {
      registrationNoError.value = "Car Registration No is required";
    } else {
      registrationNoError.value = "";
    }
    if (bookingInfoController.text == "") {
      bookingInfoError.value = "Booking Info. is required";
    } else {
      bookingInfoError.value = "";
    }

    if (selectedMechanicID.value == 0) {
      mechanicIDError.value = "Select Mechanic";
    } else {
      mechanicIDError.value = "";
    }

    if (customerNameController.text == "") {
      customerNameError.value = "Customer Name is required";
    } else {
      customerNameError.value = "";
    }
    if (customerEmailController.text == "") {
      customerEmailError.value = "Customer Email is required";
    } else {
      customerEmailError.value = "";
    }
    if (customerPhoneController.text == "") {
      customerPhoneError.value = "Customer Phone is required";
    } else {
      customerPhoneError.value = "";
    }

    if (carManufacturerError.value == "" &&
        carModelError.value == "" &&
        carYearError.value == "" &&
        registrationNoError.value == "" &&
        bookingInfoError.value == "" &&
        startTimeError.value == "" &&
        endTimeError.value == "" &&
        mechanicIDError.value == "" &&
        customerEmailError.value == "" &&
        customerNameError.value == "" &&
        customerPhoneError.value == "") {
      return true;
    }
    return false;
  }
}
