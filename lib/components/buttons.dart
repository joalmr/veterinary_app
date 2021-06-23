import 'package:flutter/material.dart';
import 'package:vet_app/design/styles/styles.dart';

Widget btnPrimary({
  @required String text,
  @required Function onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: colorMain,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorMain.withOpacity(0.5),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.5,
            letterSpacing: 0.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  // return TextButton(
  //   child: Text(text),
  //   onPressed: onPressed,
  //   style: TextButton.styleFrom(
  //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
  //     textStyle: TextStyle(fontWeight: FontWeight.bold),
  //     backgroundColor: colorMain,
  //     primary: Colors.white,
  //   ),
  // );
}

Widget btnSecondary({
  @required String text,
  @required Function onPressed,
  Color color = colorMain,
}) {
  return TextButton(
    child: Text(text),
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 15.0), //vertical: 15.0,
      alignment: Alignment.center,
      primary: color,
      side: BorderSide(color: color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
  );
}

Widget btnAltern({
  @required String text,
  @required Function onPressed,
  Color color = Colors.black54,
  bool bold = false,
}) {
  return TextButton(
    child: Text(text),
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      textStyle: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
      primary: color,
    ),
  );
}
