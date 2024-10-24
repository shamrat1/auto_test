import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:auto_ichi/screens/create_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  AuthenticationController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff5f7f8),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(200.h),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _controller.response.value.user?.name ?? "N/A",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    _controller.response.value.user?.email ?? "N/A",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff212e25),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    (_controller.response.value.user?.role ?? "N/A")
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff212e25),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              )),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.article, 'Create Booking',
                      () => Get.to(() => const CreateBookingScreen())),
                  _buildMenuItem(Icons.edit, 'Edit Profile', () {}),
                  _buildMenuItem(Icons.lock, 'Change Password', () {}),
                  _buildMenuItem(Icons.settings, 'Settings', () {}),
                  _buildMenuItem(Icons.delete, 'Delete Account', () {}),
                ],
              ),
            ),
            ListTile(
              tileColor: const Color(0xfff5f7f8),
              contentPadding: EdgeInsets.all(32.h),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.find<AuthenticationController>().logout(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      shape: const Border(bottom: BorderSide(color: Color(0xfff5f7f8))),
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
