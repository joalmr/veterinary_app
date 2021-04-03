import 'dart:async';

import 'package:get/get.dart';
import 'package:vet_app/routes/routes.dart';

class GlobalController extends GetxController {
  @override
  void onInit() {
    openApp();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  openApp() {
    Timer(Duration(milliseconds: 2500), () => Get.offNamed(NameRoutes.home));
  }
}