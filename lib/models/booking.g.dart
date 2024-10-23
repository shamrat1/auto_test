// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: (json['id'] as num?)?.toInt(),
      bookingId: json['booking_id'] as String?,
      carMake: json['car_make'] as String?,
      carModel: json['car_model'] as String?,
      carYear: json['car_year'] as String?,
      registrationPlate: json['registration_plate'] as String?,
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      customerEmail: json['customer_email'] as String?,
      bookingTitle: json['booking_title'] as String?,
      startDatetime: json['start_datetime'] == null
          ? null
          : DateTime.parse(json['start_datetime'] as String),
      endDatetime: json['end_datetime'] == null
          ? null
          : DateTime.parse(json['end_datetime'] as String),
      mechanicId: json['mechanic_id'] as String?,
      createdBy: json['created_by'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      mechanic: json['mechanic'] == null
          ? null
          : User.fromJson(json['mechanic'] as Map<String, dynamic>),
      admin: json['admin'] == null
          ? null
          : User.fromJson(json['admin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'car_make': instance.carMake,
      'car_model': instance.carModel,
      'car_year': instance.carYear,
      'registration_plate': instance.registrationPlate,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'customer_email': instance.customerEmail,
      'booking_title': instance.bookingTitle,
      'start_datetime': instance.startDatetime?.toIso8601String(),
      'end_datetime': instance.endDatetime?.toIso8601String(),
      'mechanic_id': instance.mechanicId,
      'created_by': instance.createdBy,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'mechanic': instance.mechanic,
      'admin': instance.admin,
    };
