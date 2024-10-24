import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/screens/booking_edit_screen.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    super.key,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Booking Details"),
        actions: [
          if (Get.find<AuthenticationController>().isAdmin())
            IconButton.filled(
              color: Colors.white,
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor,
              )),
              onPressed: () => _controller.onTapEdit(),
              icon: const Icon(
                Icons.edit_calendar_rounded,
              ),
            ),
          if (Get.find<AuthenticationController>().isAdmin())
            SizedBox(
              width: 16.w,
            )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  "Vehicle Details",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              _getDataRow("Manufacturer",
                  _controller.selectedBooking.value?.carMake ?? "N/A"),
              _getDataRow("Model",
                  _controller.selectedBooking.value?.carModel ?? "N/A"),
              _getDataRow(
                  "Year", _controller.selectedBooking.value?.carYear ?? "N/A"),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  "Service Details",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              _getDataRow(
                  "Booking ID",
                  (_controller.selectedBooking.value?.bookingId ?? "N/A")
                      .substring(0, 6)
                      .toUpperCase()),
              _getDataRow("Issue",
                  _controller.selectedBooking.value?.bookingTitle ?? "N/A"),
              if (_controller.selectedBooking.value?.startDatetime != null) ...[
                _getDataRow(
                    "Booking Date",
                    DateFormat("d-M-y hh:mm a").format(
                        _controller.selectedBooking.value!.startDatetime!)),
                _getDataRow("Total Time Booked ",
                    "${_difference(_controller.selectedBooking.value!.startDatetime!, _controller.selectedBooking.value?.endDatetime ?? _controller.selectedBooking.value!.startDatetime!)} Hour"),
              ],
              _getDataRow("Technician",
                  _controller.selectedBooking.value?.mechanic?.name ?? "N/A"),
              _getDataRow(
                  "Status",
                  (_controller.selectedBooking.value?.status ?? "N/A")
                      .toUpperCase(),
                  color: _controller.getBookingColor(
                      _controller.selectedBooking.value?.status ?? "")),
              SizedBox(
                height: 20.h,
              ),
              if (Get.find<AuthenticationController>().isAdmin()) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    "Customer Details",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                _getDataRow("Name",
                    _controller.selectedBooking.value?.customerName ?? "N/A"),
                _getDataRow("Email",
                    _controller.selectedBooking.value?.customerEmail ?? "N/A"),
                _getDataRow("Phone",
                    _controller.selectedBooking.value?.customerPhone ?? "N/A"),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _difference(DateTime start, DateTime end) {
    Duration difference = end.difference(start);

    // Convert the difference to hours
    double hoursDifference = difference.inMinutes / 60;
    return hoursDifference.toStringAsFixed(2);
  }

  Widget _getDataRow(String key, String value, {Color? color}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor.withAlpha(20),
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          if (color == null)
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w800),
            ),
          if (color != null)
            Container(
              padding: EdgeInsets.all(4.h),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
