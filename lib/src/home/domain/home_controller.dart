import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/src/bookings/data/booking_repository.dart';
import 'package:vet_app/src/bookings/data/model/booking_model.dart';
import 'package:vet_app/src/establishments/data/establishment_repository.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HomeController extends GetxController {
  final establishmentService = EstablishmentRepository();
  final _repoBooking = BookingRepository();

  final RxBool _carga = true.obs;
  bool get carga => _carga.value;
  set carga(bool value) => _carga.value = value;

  final RxBool _cargaConfirmar = false.obs;
  bool get cargaConfirmar => _cargaConfirmar.value;
  set cargaConfirmar(bool value) => _cargaConfirmar.value = value;

  final nameVet = ''.obs;

  final unconfirmed = RxList<Booking>();
  final overdue = RxList<Booking>();
  final today = RxList<Booking>();
  final incoming = RxList<Booking>();

////////////////////////////////////////////////////////////////////////////////

  @override
  void onInit() {
    if (prefUser.tokenHas() &&
        prefUser.vetDataHas() &&
        prefUser.vetIdSupaHas()) {
      getVet();
      getAllBookings();
    }

    super.onInit();
  }

  launchWhatsApp(String phone, String user, String petName, String date,
      String time) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+51$phone',
      text:
          '''Hola $user somos de ${prefUser.vetName}, nos comunicamos por la reserva de $petName\nFecha: $date\nHora: $time''',
    );
    await launch('$link');
  }

  refreshUnconfirmed() => _refreshUnconfirmed();

  Future<dynamic> _refreshUnconfirmed() async {
    carga = true;
    await Future.delayed(const Duration(milliseconds: 2));
    getUnconfirmed();
    return null;
  }

  getVet() {
    nameVet.value = prefUser.vetName!;
  }

  //*   listas bookings
  getUnconfirmed() => _getUnconfirmed();
  Future<void> _getUnconfirmed() async {
    unconfirmed.clear();
    final response = await _repoBooking.getUnconfirmed(prefUser.vetId!);
    unconfirmed.addAll(response.result!);
  }

  getOverdue() => _getOverdue();
  Future<void> _getOverdue() async {
    overdue.clear();
    final response = await _repoBooking.getOverdue(prefUser.vetId!);
    overdue.addAll(response.result!);
  }

  getToday() => _getToday();
  Future<void> _getToday() async {
    today.clear();
    final response = await _repoBooking.getToday(prefUser.vetId!);
    today.addAll(response.result!);
  }

  getIncoming() => _getIncoming();
  Future<void> _getIncoming() async {
    incoming.clear();
    final response = await _repoBooking.getIncoming(prefUser.vetId!);
    incoming.addAll(response.result!);
  }

  getAllBookings() => _getAllBookings();
  Future<void> _getAllBookings() async {
    carga = true;
    await getUnconfirmed();
    await getToday();
    await getIncoming();
    await getOverdue();
    carga = false;
  }

  //!   confirmar
  //
  confirm(String idBooking) => _confirm(idBooking);
  Future<void> _confirm(String idBooking) async {
    carga = true;
    final int resp = await _repoBooking.confirm(idBooking);
    if (resp == 200) {
      getAllBookings();
    }
    cargaConfirmar = false;
  }
}
