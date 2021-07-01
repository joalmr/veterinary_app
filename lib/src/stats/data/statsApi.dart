import 'package:vet_app/config/variablesGlobal.dart';
import 'package:vet_app/resources/utils/headerHttp.dart';
import 'package:vet_app/src/stats/data/model/statsBaseModel.dart';
import 'package:vet_app/src/stats/data/model/statCommentModel.dart';
import 'package:http/http.dart' as http;
import 'package:vet_app/src/stats/data/model/statsServiceModel.dart';
import 'package:vet_app/src/stats/data/model/statsUserModel.dart';

import '_statsInterface.dart';
import 'model/statsSalesDailyModel.dart';
import 'model/statsSalesMonthlyModel.dart';

class StatsApi extends StatsInterface {
  @override
  Future<StatBaseModel> getStatsBase(
      String establecimientoId, String from, String to) async {
    print('getStatsBase');
    final url = Uri.https(
      urlBase,
      '$pathBase/establishment/$establecimientoId/stats',
      {
        "from": from,
        "to": to,
      },
    );

    http.Response response = await http.get(url, headers: headersToken());
    print(response.statusCode);
    final statsBase = statBaseModelFromJson(response.body);

    return statsBase;
  }

  @override
  Future<List<StatCommentModel>> getStatsComment(
      String establecimientoId, String from, String to) async {
    print('getStatsComment');
    final url = Uri.https(
      urlBase,
      '$pathBase/establishment/$establecimientoId/comments',
      {
        "from": from,
        "to": to,
      },
    );

    http.Response response = await http.get(url, headers: headersToken());
    print(response.statusCode);
    final statsComment = statCommentModelFromJson(response.body);

    return statsComment;
  }

  @override
  Future<StatsServiceModel> getStatsService(String establecimientoId, String from, String to) async {
    print('getStatsService');
    final url = Uri.https(
      urlBase,
      '$pathBase/establishment/$establecimientoId/stats/services',
      {
        "from": from,
        "to": to,
      },
    );

    http.Response response = await http.get(url, headers: headersToken());
    final statsService = statsServiceModelFromJson(response.body);

    return statsService;
  }

  @override
  Future<StatsSalesDailyModel> getStatsDaily(String establecimientoId) async {
    print('getStatsDaily');
    final url = Uri.https(
      urlBase,
      '$pathBase/establishment/$establecimientoId/stats/sales',
      {
        "type": "daily",
      },
    );

    http.Response response = await http.get(url, headers: headersToken());
    final salesDaily = statsSalesDailyModelFromJson(response.body);

    return salesDaily;
  }
  
  @override
  Future<StatsSalesMonthlyModel> getStatsMonthly(String establecimientoId) async {
    print('getStatsMonthly');
    final url = Uri.https(
      urlBase,
      '$pathBase/establishment/$establecimientoId/stats/sales',
      {
        "type": "monthly",
      },
    );

    http.Response response = await http.get(url, headers: headersToken());
    
    final salesMonthly = statsSalesMonthlyModelFromJson(response.body);

    return salesMonthly;
  }

  @override
  Future<StatsUserModel> getStatsUser(String establecimientoId) async {
    final url = Uri.https(
      urlBase,
      '$pathBase/establishment/$establecimientoId/stats/users',
    );

    http.Response response = await http.get(url, headers: headersToken());
    final statsUser = statsUserModelFromJson(response.body);

    return statsUser;
  }  
}
