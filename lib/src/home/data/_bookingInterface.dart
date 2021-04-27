import 'package:vet_app/src/home/data/model/bookingModel.dart';

abstract class BookingInterface {
  Future<int> confirm(String idBooking);
  Future<int> reschedule(String idBooking, String bookingAt);
  Future<BookingModel> getId(String idBooking);
  // Future<List<ReservaModel>> getAll(String idVet);
  Future<BookingModel> getUnconfirmed(String idVet);
  Future<BookingModel> getOverdue(String idVet);
  Future<BookingModel> getToday(String idVet);
  Future<BookingModel> getIncoming(String idVet);
}
