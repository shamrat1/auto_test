import 'package:auto_ichi/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking.g.dart';

List<Booking> bookingFromJsonList(List<dynamic> str) =>
    List<Booking>.from(str.map((x) => Booking.fromJson(x)));

@JsonSerializable(fieldRename: FieldRename.snake)
class Booking {
  int? id;
  String? bookingId;
  String? carMake;
  String? carModel;
  String? carYear;
  String? registrationPlate;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? bookingTitle;
  DateTime? startDatetime;
  DateTime? endDatetime;
  String? mechanicId;
  String? createdBy;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? mechanic;
  User? admin;

  Booking({
    this.id,
    this.bookingId,
    this.carMake,
    this.carModel,
    this.carYear,
    this.registrationPlate,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.bookingTitle,
    this.startDatetime,
    this.endDatetime,
    this.mechanicId,
    this.createdBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mechanic,
    this.admin,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
