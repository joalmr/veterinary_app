import 'dart:async';
import 'package:get/get.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/routes/routes.dart';
import 'package:vet_app/src/_auth/domain/push_controller.dart';
import 'package:vet_app/src/calendar/domain/calendar_controller.dart';
import 'package:vet_app/src/establishments/domain/establishments_controller.dart';
import 'package:vet_app/src/home/domain/home_controller.dart';
import 'package:vet_app/src/registros/domain/attentions_controller.dart';
import 'package:vet_app/src/userClients/domain/user_clients_controller.dart';

class GlobalController extends GetxController {
  bool init = false;

  final _home = Get.find<HomeController>();
  final _calendar = Get.find<CalendarController>();
  final _attention = Get.find<AttentionsController>();
  final _clients = Get.find<ClientsController>();
  final _establishment = Get.find<EstablishmentsController>();

  // final pushController = PushController();

  @override
  void onInit() {
    openApp();
    super.onInit();
  }

  void generalLoad() {
    _home.getAllBookings();
    _calendar.loadCalendar();
    _attention.getAll();
    _establishment.getAll();
    _clients.getClients();
  }

  void openApp() {
    if (prefUser.tokenHas() == true && prefUser.vetDataHas() == true) {
      // pushController.firebase(); // TODO: firebase
      Timer(const Duration(milliseconds: 2500),
          () => Get.offNamed(NameRoutes.home));
    } else {
      Timer(const Duration(milliseconds: 2500),
          () => Get.offNamed(NameRoutes.login));
    }
  }
}
