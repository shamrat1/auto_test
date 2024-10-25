import 'package:auto_ichi/models/booking.dart';
import 'package:auto_ichi/models/dashboard.dart';
import 'package:auto_ichi/models/user.dart';
import 'package:auto_ichi/utils/http/http_client.dart';
import 'package:dartz/dartz.dart';

class BookingRepository {
  Future<Either<String, List<Booking>>> getBookings(
      {String? startDate, String? endDate}) async {
    try {
      var url = "bookings";
      // if (startDate != null) {
      //   url += "start=$startDate";
      // }
      // if (endDate != null) {
      //   url += "&end=$endDate";
      // }
      // print(url);
      var response = await THttpHelper.get(url);
      print(response);
      return right(bookingFromJsonList(response as List<dynamic>));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<User>>> getMechanics() async {
    try {
      var url = "mechanics";

      var response = await THttpHelper.get(url);
      return right(userFromJsonList(response as List<dynamic>));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, Dashboard>> getDashboard() async {
    try {
      var url = "dashboard";

      var response = await THttpHelper.get(url);

      return right(Dashboard.fromJson(response));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, dynamic>> createBooking(
      Map<String, dynamic> data) async {
    try {
      var response = await THttpHelper.post("booking/create", data);
      return right("ok");
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, dynamic>> updateBooking(
      int bookingID, Map<String, dynamic> data) async {
    try {
      var response = await THttpHelper.post("booking/$bookingID/update", data);
      return right("ok");
    } catch (e) {
      return left(e.toString());
    }
  }
}
