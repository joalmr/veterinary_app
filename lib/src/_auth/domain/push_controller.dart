import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/_auth/data/auth_repository.dart';

class PushController extends GetxController {
  final fireLogin = AuthRepository();
  // final homeC = Get.find<HomeController>();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  firebase() => _firebase();
  Future<void> _firebase() async {
    firebasePermiso();
    firebaseToken();
  }

  firebasePermiso() async {
    await _firebaseMessaging.requestPermission();
  }

  void firebaseToken() {
    _firebaseMessaging.getToken().then((token) {
      print("==firebase token==");
      print(token);
      fireLogin.sendTokenFire(token!);
    });
  }

  void firebaseConfigure() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('getInitialMessage');
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print('onMessage');
      if (message != null) {}
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      print('onMessageOpenedApp');
      if (message != null) {}
    });
  }
}