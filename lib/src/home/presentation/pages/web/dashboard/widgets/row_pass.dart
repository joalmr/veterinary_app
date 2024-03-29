import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/utils/datetime_format.dart';
import 'package:vet_app/src/home/domain/home_controller.dart';

import 'row_booking.dart';

class RowPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (_) {
        return Expanded(
          child: _.overdue.isEmpty
              ? const Center(
                  child: Text('No tiene atenciones pasadas'),
                )
              : ListView.builder(
                  itemCount: _.overdue.length,
                  itemBuilder: (BuildContext context, int index) {
                    final overdue = _.overdue[index];
                    return RowBooking(
                      bookingId: overdue.id!,
                      petId: overdue.petId!,
                      petImg: overdue.petPicture!,
                      petName: overdue.petName!,
                      petBreed: overdue.petBreed!,
                      color: colorGreen,
                      status: overdue.bookingStatus!,
                      date: formatDate(overdue.bookingDate!),
                      time: overdue.bookingTime!.substring(0, 5),
                      userName: overdue.user!,
                      userPhone: overdue.userPhone.toString(),
                      bookingServices: overdue.bookingServices!,
                      observation: overdue.observation!,
                      address: overdue.options!.address!,
                      delivery: overdue.options!.delivery!,
                    );
                  },
                ),
        );
      },
    );
  }
}
