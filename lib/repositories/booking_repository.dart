import 'package:auto_ichi/models/booking.dart';
import 'package:auto_ichi/models/user.dart';
import 'package:auto_ichi/utils/http/http_client.dart';
import 'package:dartz/dartz.dart';

class BookingRepository {
  Future<Either<String, List<Booking>>> getBookings(
      {String? startDate, String? endDate}) async {
    try {
      var url = "bookings";
      if (startDate != null) {
        url += "start=$startDate";
      }
      if (endDate != null) {
        url += "end=$endDate";
      }
      var response = await THttpHelper.get(url);
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
}
