import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthenticationController _controller = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((c) {
      _controller.getDashboard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.loading.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            if (_controller.isAdmin())
              _getDashboardItem("Mechanics",
                  (_controller.dashboard.value.mechanics ?? 0).toString()),
            _getDashboardItem("Pending Bookings",
                (_controller.dashboard.value.pending ?? 0).toString()),
            _getDashboardItem("No Show Bookings",
                (_controller.dashboard.value.noShow ?? 0).toString()),
            _getDashboardItem("Completed Bookings",
                (_controller.dashboard.value.completed ?? 0).toString(),
                color: Colors.green),
            _getDashboardItem("Cancelled Bookings",
                (_controller.dashboard.value.cancelled ?? 0).toString(),
                color: Colors.red),
            _getDashboardItem("In Progress Bookings",
                (_controller.dashboard.value.inProgress ?? 0).toString(),
                color: Colors.amber),
            _getDashboardItem("Wating For Parts Bookings",
                (_controller.dashboard.value.waitingForParts ?? 0).toString(),
                color: Colors.red),
          ],
        ),
      );
    });
  }

  Widget _getDashboardItem(String key, String value, {Color? color}) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 12.w, left: 12.w),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            key,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
