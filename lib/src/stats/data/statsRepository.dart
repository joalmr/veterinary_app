import 'package:vet_app/src/stats/data/model/statsBaseModel.dart';

import 'package:vet_app/src/stats/data/model/statCommentModel.dart';

import '_statsInterface.dart';
import 'statsApi.dart';

class StatsRepository extends StatsInterface {
  final _api = StatsApi();

  @override
  Future<StatBaseModel> getStatsBase(
      String establecimientoId, String from, String to) {
    return _api.getStatsBase(establecimientoId, from, to);
  }

  @override
  Future<List<StatCommentModel>> getStatsComment(
      String establecimientoId, String from, String to) {
    return _api.getStatsComment(establecimientoId, from, to);
  }
}
