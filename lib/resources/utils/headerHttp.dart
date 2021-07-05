import 'dart:io';
import 'package:vet_app/config/variablesGlobal.dart';

headersToken() {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: 'Bearer ${prefUser.token}',
    'X-Requested-With': 'XMLHttpRequest',
  };
}
