// To parse this JSON data, do
//
//     final dewormingBooking = dewormingBookingFromJson(jsonString);

import 'dart:convert';

DewormingBooking dewormingBookingFromJson(String str) =>
    DewormingBooking.fromJson(json.decode(str));

String dewormingBookingToJson(DewormingBooking data) =>
    json.encode(data.toJson());

class DewormingBooking {
  DewormingBooking({
    this.amount,
    this.dewormers,
    this.recommendations,
  });

  double? amount;
  List<Dewormer>? dewormers;
  String? recommendations;

  factory DewormingBooking.fromJson(Map<String, dynamic> json) =>
      DewormingBooking(
        amount: json['amount'] as double? ?? 0.0,
        dewormers: List<Dewormer>.from(
            json['dewormers'].map((x) => Dewormer.fromJson(x))),
        recommendations: json['recommendations'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'dewormers':
            List<dynamic>.from(dewormers?.map((x) => x.toJson()) ?? []),
        'recommendations': recommendations,
      };
}

List<Dewormer> dewormingsModelFromJson(String str) =>
    List<Dewormer>.from(json.decode(str).map((x) => Dewormer.fromJson(x)));

String dewormingsModelToJson(List<Dewormer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dewormer {
  Dewormer({
    this.id,
    this.name,
    this.laboratory,
    this.types,
  });

  int? id;
  String? name;
  String? laboratory;
  List<String>? types;

  factory Dewormer.fromJson(Map<String, dynamic> json) => Dewormer(
        id: json['id'] as int?,
        name: json['name'] as String?,
        laboratory: json['laboratory'] as String?,
        types: List<String>.from(json['types'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'laboratory': laboratory,
        'types': List<dynamic>.from(types?.map((x) => x) ?? []),
      };
}
