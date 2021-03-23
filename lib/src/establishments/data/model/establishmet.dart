import 'dart:convert';
import 'package:get/get.dart';

class RxEstablishmentModal {
  RxString id;
  RxString name;
  RxString stars;
  RxString logo;
  RxString description;
  Schedule schedule;
  Prices prices;
  List<Employee> employees;

  RxEstablishmentModal({
    this.id,
    this.name,
    this.stars,
    this.logo,
    this.description,
    this.schedule,
    this.prices,
    this.employees,
  });
}

EstablishmentModal establishmentModalFromJson(String str) =>
    EstablishmentModal.fromJson(json.decode(str));

String establishmentModalToJson(EstablishmentModal data) =>
    json.encode(data.toJson());

class EstablishmentModal {
  String id;
  String name;
  String stars;
  String logo;
  String description;
  Schedule schedule;
  Prices prices;
  List<Employee> employees;

  EstablishmentModal({
    this.id,
    this.name,
    this.stars,
    this.logo,
    this.description,
    this.schedule,
    this.prices,
    this.employees,
  });

  factory EstablishmentModal.fromJson(Map<String, dynamic> json) =>
      EstablishmentModal(
        id: json["id"],
        name: json["name"],
        stars: json["stars"],
        logo: json["logo"],
        description: json["description"],
        schedule: Schedule.fromJson(json["schedule"]),
        prices: Prices.fromJson(json["prices"]),
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stars": stars,
        "logo": logo,
        "description": description,
        "schedule": schedule.toJson(),
        "prices": prices.toJson(),
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
      };
}

class Employee {
  String id;
  String establishmentId;
  int typeId;
  String name;
  String code;

  Employee({
    this.id,
    this.establishmentId,
    this.typeId,
    this.name,
    this.code,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        establishmentId: json["establishment_id"],
        typeId: json["type_id"],
        name: json["name"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "establishment_id": establishmentId,
        "type_id": typeId,
        "name": name,
        "code": code == null ? null : code,
      };
}

class Prices {
  Price consultation;
  Price deworming;
  Price vaccination;
  Price grooming;

  Prices({
    this.consultation,
    this.deworming,
    this.vaccination,
    this.grooming,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        consultation: Price.fromJson(json["consultation"]),
        deworming: Price.fromJson(json["deworming"]),
        vaccination: Price.fromJson(json["vaccination"]),
        grooming: Price.fromJson(json["grooming"]),
      );

  Map<String, dynamic> toJson() => {
        "consultation": consultation.toJson(),
        "deworming": deworming.toJson(),
        "vaccination": vaccination.toJson(),
        "grooming": grooming.toJson(),
      };
}

class Price {
  Price({
    this.from,
    this.to,
  });

  int from;
  dynamic to;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        from: json["from"] == null ? null : json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "from": from == null ? null : from,
        "to": to,
      };
}

class Schedule {
  Schedule({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  Day monday;
  Day tuesday;
  Day wednesday;
  Day thursday;
  Day friday;
  Day saturday;
  Day sunday;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        monday: Day.fromJson(json["monday"]),
        tuesday: Day.fromJson(json["tuesday"]),
        wednesday: Day.fromJson(json["wednesday"]),
        thursday: Day.fromJson(json["thursday"]),
        friday: Day.fromJson(json["friday"]),
        saturday: Day.fromJson(json["saturday"]),
        sunday: Day.fromJson(json["sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "monday": monday.toJson(),
        "tuesday": tuesday.toJson(),
        "wednesday": wednesday.toJson(),
        "thursday": thursday.toJson(),
        "friday": friday.toJson(),
        "saturday": saturday.toJson(),
        "sunday": sunday.toJson(),
      };
}

class Day {
  Day({
    this.daySwitch,
    this.timeStart,
    this.timeEnd,
  });

  bool daySwitch;
  String timeStart;
  String timeEnd;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        daySwitch: json["switch"],
        timeStart: json["time_start"] == null ? null : json["time_start"],
        timeEnd: json["time_end"] == null ? null : json["time_end"],
      );

  Map<String, dynamic> toJson() => {
        "switch": daySwitch,
        "time_start": timeStart == null ? null : timeStart,
        "time_end": timeEnd == null ? null : timeEnd,
      };
}