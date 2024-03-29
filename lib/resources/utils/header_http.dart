import 'dart:io';
import 'package:vet_app/config/variables_global.dart';

Map<String, String> headersToken() {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: 'Bearer ${prefUser.token}',
    'X-Requested-With': 'XMLHttpRequest',
  };
}
