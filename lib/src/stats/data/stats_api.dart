import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/resources/utils/header_http.dart';
import 'package:vet_app/src/stats/data/model/service_stats_versus_sales.model.dart';
import 'package:vet_app/src/stats/data/model/stats_base_model.dart';
import 'package:vet_app/src/stats/data/model/stat_comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:vet_app/src/stats/data/model/stats_service_model.dart';
import 'package:vet_app/src/stats/data/model/stats_user_model.dart';

import '_stats_interface.dart';
import 'model/stats_sales_daily_model.dart';
import 'model/stats_sales_monthly_model.dart';

class StatsApi extends StatsInterface {
  @override
  Future<StatBaseModel> getStatsBase(
      String establecimientoId, String from, String to) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/stats',
      {
        'from': from,
        'to': to,
      },
    );

    final http.Response response = await http.get(url, headers: headersToken());

    final statsBase = statBaseModelFromJson(response.body);

    return statsBase;
  }

  @override
  Future<List<StatCommentModel>> getStatsComment(
      String establecimientoId, String from, String to) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/comments',
      {
        'from': from,
        'to': to,
      },
    );

    final http.Response response = await http.get(url, headers: headersToken());

    final statsComment = statCommentModelFromJson(response.body);

    return statsComment;
  }

  @override
  Future<ServicesStatsModel> servicesStat(
    String establecimientoId,
    String fechain,
    String fechaout,
  ) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/stats/attentions',
      {
        'from': fechain,
        'to': fechaout,
      },
    );

    final response = await http.get(url, headers: headersToken());

    final servicesStatsModel = servicesStatsModelFromJson(response.body);

    return servicesStatsModel;
  }

  @override
  Future<StatsServiceModel> getStatsService(
      String establecimientoId, String from, String to) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/stats/services',
      {
        'from': from,
        'to': to,
      },
    );

    final http.Response response = await http.get(url, headers: headersToken());
    final statsService = statsServiceModelFromJson(response.body);

    return statsService;
  }

  @override
  Future<StatsSalesDailyModel> getStatsDaily(String establecimientoId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/stats/sales',
      {
        'type': 'daily',
      },
    );

    final http.Response response = await http.get(url, headers: headersToken());
    final salesDaily = statsSalesDailyModelFromJson(response.body);

    return salesDaily;
  }

  @override
  Future<StatsSalesMonthlyModel> getStatsMonthly(
      String establecimientoId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/stats/sales',
      {
        'type': 'monthly',
      },
    );

    final http.Response response = await http.get(url, headers: headersToken());

    final salesMonthly = statsSalesMonthlyModelFromJson(response.body);

    return salesMonthly;
  }

  @override
  Future<StatsUserModel> getStatsUser(String establecimientoId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/stats/users',
    );

    final http.Response response = await http.get(url, headers: headersToken());
    final statsUser = statsUserModelFromJson(response.body);

    return statsUser;
  }
}
