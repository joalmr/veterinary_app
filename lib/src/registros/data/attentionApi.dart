import 'dart:convert';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/resources/utils/header_http.dart';
import 'package:vet_app/src/registros/data/model/attentionRegModel.dart';
import 'package:http/http.dart' as http;
import '_attentionsInterface.dart';
import 'model/filterAttention.dart';

class AttentionApi extends AttentionInterface {
  @override
  Future<AttentionRegModel> getAll(
      String idVet, FilterAttention filtros) async {
    final url = Uri.https(
      urlBase!,
      '/api/client/establishment/$idVet/attentions',
    );

    http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(filtros),
    );

    return AttentionRegModel.fromJson(json.decode(response.body));
  }
}
