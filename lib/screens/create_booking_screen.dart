import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/controllers/create_booking_controller.dart';
import 'package:auto_ichi/models/user.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:auto_ichi/utils/constants/custom_textfields.dart';
import 'package:auto_ichi/utils/constants/shadows.dart';
import 'package:auto_ichi/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateBookingScreen extends StatelessWidget {
  CreateBookingScreen({super.key});
  CreateBookingController _controller = Get.put(CreateBookingController());
  BookingsController _bookingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Booking"),
        centerTitle: false,
        actions: [
          IconButton.filled(
            color: Colors.white,
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).primaryColor,
            )),
            onPressed: () => _controller.login(),
            icon: const Icon(
              Icons.save,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return Padding(
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.carManufacturerController,
                          hintText: "Car Manufacturer"),
                      _errorWidget(_controller.carManufacturerError.value),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.carModelController,
                          hintText: "Car Model"),
                      _errorWidget(_controller.carModelError.value),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.carModelYearController,
                          hintText: "Car Year"),
                      _errorWidget(_controller.carYearError.value),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.registrationNoController,
                          hintText: "Registration No."),
                      _errorWidget(_controller.registrationNoError.value),
                    ],
                  ),
                ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.bookingInfoController,
                          hintText: "Booking Info"),
                      _errorWidget(_controller.bookingInfoError.value),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                    boxShadow: TShadows.primaryBoxShadow,
                  ),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => _controller.showDateTimeSelector(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking Start Time",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: TColors.darkGrey,
                                  ),
                        ),
                        Text(DateFormat("d-M-y hh:mm a")
                            .format(_controller.selectedStartTime.value)),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                    boxShadow: TShadows.primaryBoxShadow,
                  ),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => _controller.showDateTimeSelector(false),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking End Time",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: TColors.darkGrey,
                                  ),
                        ),
                        Text(DateFormat("d-M-y hh:mm a")
                            .format(_controller.selectedEndTime.value)),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusMd),
                        boxShadow: TShadows.primaryBoxShadow,
                      ),
                      child: DropdownButton<int>(
                        dropdownColor: TColors.grey,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(10.r),
                        hint: const Text('Select Mechanic'),
                        value: _controller.selectedMechanicID.value != 0
                            ? _controller.selectedMechanicID.value
                            : null,
                        onChanged: (int? value) {
                          _controller.selectedMechanicID.value = value!;
                        },
                        items:
                            (_bookingsController.mechanics).map((User value) {
                          return DropdownMenuItem<int>(
                            value: value.id ?? 0,
                            child: Text(value.name ?? "N/A"),
                          );
                        }).toList(),
                      ),
                    ),
                    _errorWidget(_controller.mechanicIDError.value),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    "Customer Details",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.customerNameController,
                          hintText: "Customer Name"),
                      _errorWidget(_controller.customerNameError.value),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.customerEmailController,
                          hintText: "Customer Email",
                          textInputType: TextInputType.emailAddress),
                      _errorWidget(_controller.customerEmailError.value),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                          context, _controller.customerPhoneController,
                          hintText: "Customer Phone",
                          textInputType: TextInputType.number),
                      _errorWidget(_controller.customerPhoneError.value),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _errorWidget(String error) {
    if (error.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.only(top: 8.h),
      alignment: Alignment.centerLeft,
      child: Text(
        error,
        style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }
}
