import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/models/user.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookingEditScreen extends StatefulWidget {
  const BookingEditScreen({super.key});

  @override
  State<BookingEditScreen> createState() => _BookingEditScreenState();
}

class _BookingEditScreenState extends State<BookingEditScreen> {
  final BookingsController _controller = Get.find();
  final List<String> _status = [
    'pending',
    'in-progress',
    'waiting-for-parts',
    'no-show',
    'complete',
    'cancelled'
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Update Booking Details"),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 4.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: TColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Text(
                        "Status",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: TColors.grey,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(10.r),
                        hint: const Text('Select Status'),
                        value: _controller.selectedBooking.value.status ??
                            "pending",
                        onChanged: (String? newValue) =>
                            _controller.selectedStatus(newValue),
                        items: _status.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: TColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Text(
                        "Mechanic / Technician",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: DropdownButton<int>(
                        dropdownColor: TColors.grey,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(10.r),
                        hint: const Text('Select Mechanic'),
                        value: _controller.selectedMechanicID.value,
                        onChanged: (int? value) {
                          _controller.selectedMechanicID.value = value!;
                        },
                        items: (_controller.mechanics).map((User value) {
                          return DropdownMenuItem<int>(
                            value: value.id ?? 0,
                            child: Text(value.name ?? "N/A"),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () => _controller.updateBooking(),
                  child: _controller.loading.value
                      ? const CircularProgressIndicator.adaptive()
                      : const Text("Update")),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      );
    });
  }
}
