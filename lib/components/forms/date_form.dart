// import 'package:intl/intl.dart';

// //! para utilizar en los controladores
// String? validaDate(String texto) {
//   if (texto.isEmpty) return 'Ingrese fecha';
//   if (texto.length < 10) return 'Complete fecha';

//   final dateWrite = texto.split('-');
//   final int year = int.parse(dateWrite[2]);
//   final int month = int.parse(dateWrite[1]);
//   final int day = int.parse(dateWrite[0]);
//   final int lastday = DateTime(year, month + 1, 0).day;

//   if (day < 1 || day > 31 || month < 1 || month > 12) {
//     return 'Formato de fecha invalido';
//   } else {
//     if (lastday < day) {
//       return 'El día seleccionado no es correcto';
//     } else {
//       final DateTime dateNow = DateTime.now();
//       final dateFormat = DateFormat('dd-MM-yyyy');
//       final DateTime tempDate = dateFormat.parse(texto);

//       final int diff = tempDate.difference(dateNow).inDays;
//       if (diff < 0) return 'Debe escribir una fecha mayor';
//     }
//   }
//   return null;
// }
