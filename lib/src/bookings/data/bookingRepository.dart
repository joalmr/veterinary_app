import 'bookingApi.dart';
import '_bookingInterface.dart';
import 'model/bookingModel.dart';

class BookingRepository extends BookingInterface {
  final _api = BookingApi();

  @override
  Future<int> confirm(String idBooking) {
    return _api.confirm(idBooking);
  }

  @override
  Future<int> reschedule(String idBooking, String bookingAt) {
    return _api.reschedule(idBooking, bookingAt);
  }

  @override
  Future<void> attend(String establishment, String booking) {
    return _api.attend(establishment, booking);
  }

  @override
  Future<BookingModel> getId(String idBooking) {
    return _api.getId(idBooking);
  }

  @override
  Future<BookingModel> getIncoming(String idVet) {
    return _api.getIncoming(idVet);
  }

  @override
  Future<BookingModel> getOverdue(String idVet) {
    return _api.getOverdue(idVet);
  }

  @override
  Future<BookingModel> getToday(String idVet) {
    return _api.getToday(idVet);
  }

  @override
  Future<BookingModel> getUnconfirmed(String idVet) {
    return _api.getUnconfirmed(idVet);
  }
}
