import 'package:flutter/material.dart';

Widget cardContainer({required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black12.withOpacity(0.05),
      //     blurRadius: 5.0,
      //     spreadRadius: 1.0,
      //     offset: Offset(0, 1), // changes position of shadow
      //   ),
      // ],
    ),
    child: child,
  );
}
