import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/_supabase/services/product/product.repo.dart';
import 'package:vet_app/components/snackbar.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/utils/datetime_format.dart';
import 'package:vet_app/components/color_generate.dart';
import 'package:vet_app/src/stats/data/model/service_stats_versus_sales.model.dart';
import 'package:vet_app/src/stats/data/model/stat_comment_model.dart';
import 'package:vet_app/src/stats/data/model/stats_base_model.dart';
import 'package:vet_app/src/stats/data/model/stats_sales_daily_model.dart';
import 'package:vet_app/src/stats/data/model/stats_sales_monthly_model.dart';
import 'package:vet_app/src/stats/data/model/stats_service_model.dart';
import 'package:vet_app/src/stats/data/stats_repository.dart';

class StatsController extends GetxController {
  final _repo = StatsRepository();
  final _repoGeneralVs = ProductGeneralRepo();

  final fechaIn = TextEditingController();
  final fechaOut = TextEditingController();

  RxString msgfechaIn = ''.obs;
  RxString msgfechaOut = ''.obs;

  final statBase = StatBaseModel().obs;
  final statComments = <StatCommentModel>[].obs;
  final services = <Services>[].obs;
  final salesDay = <SalesDay>[].obs;
  final salesMonth = <SalesMonth>[].obs;

  final cargaBase = false.obs;
  final cargaComments = false.obs;
  final cargaServices = false.obs;
  final cargaSalesDay = false.obs;
  final cargaSalesMonth = false.obs;

  double generalIngresos = 0;
  double generalEgresos = 0;

  dynamic generalVersus = [];
  dynamic totalValuesversus;
  ServicesStatsModel servicesSalesStats = ServicesStatsModel();

  final hoy = DateTime.now();

  DateTime? initialIn;
  DateTime? initialOut;

  @override
  void onInit() {
    initialIn = DateTime(hoy.year, hoy.month - 2, hoy.day);
    initialOut = hoy;

    fechaIn.text = formatDateBasic(initialIn!); //formatDate
    fechaOut.text = formatDateBasic(initialOut!);

    cargaStats();
    super.onInit();
  }

  cargaStats() async {
    getBase();
    getComments();
    getStatsService();
    getStatsDaily();
    getStatsMonthly();

    generalVersus =
        await _repoGeneralVs.generalVersus(fechaIn.text, fechaOut.text);

    servicesSalesStats =
        await _repo.servicesStat(prefUser.vetId!, fechaIn.text, fechaOut.text);

    final responseVersus =
        await _repoGeneralVs.totalValuesversus(fechaIn.text, fechaOut.text);

    generalIngresos = responseVersus['income'];
    generalEgresos = responseVersus['expense'];

    update(['versusSales']);
  }

  ejecStats() {
    final date1 = toDateBasic(fechaIn.text);
    final date2 = toDateBasic(fechaOut.text);
    final diffDate = date2.difference(date1);

    if (diffDate.inDays < 1) {
      snackBarMessage(
        type: TypeSnackBarName.ERROR,
        message: 'La "fecha desde" debe ser anterior a la "fecha hasta"',
      );
    } else {
      cargaStats();
      Get.back();
    }
  }

  ejecStatsWeb() {
    final date1 = toDateBasic(fechaIn.text);
    final date2 = toDateBasic(fechaOut.text);
    final diffDate = date2.difference(date1);

    if (diffDate.inDays < 1) {
      Get.snackbar(
        'Error',
        'La "fecha desde" debe ser anterior a la "fecha hasta"',
        backgroundColor: colorRed,
        colorText: colorWhite,
      );
    } else {
      cargaStats();
    }
  }

  Future selectIn(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialIn!,
        firstDate: DateTime(2020),
        lastDate: initialOut!.add(const Duration(days: -1)));
    if (picked != null) {
      initialIn = picked;
      fechaIn.text = formatDateBasic(picked);
    }
  }

  Future selectOut(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialOut!,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null) {
      initialOut = picked;
      fechaOut.text = formatDateBasic(picked);
    }
  }

  getBase() => _getBase();
  Future<void> _getBase() async {
    cargaBase.value = true;
    final response =
        await _repo.getStatsBase(prefUser.vetId!, fechaIn.text, fechaOut.text);
    statBase.update((val) {
      val!.stars = response.stars;
      val.votes = response.votes;
      val.dogs = response.dogs;
      val.cats = response.cats;
      val.nonAttendedPercentage = response.nonAttendedPercentage;
    });
    cargaBase.value = false;
  }

  getComments() => _getComments();
  Future<void> _getComments() async {
    cargaComments.value = true;
    statComments.clear();
    final values = await _repo.getStatsComment(
        prefUser.vetId!, fechaIn.text, fechaOut.text);
    statComments.addAll(values);
    cargaComments.value = false;
  }

  final paiChartList = <PieChartSectionData>[].obs;
  final radiusPie = 25.obs;
  getStatsService() => _getStatsService();
  Future<void> _getStatsService() async {
    cargaServices.value = true;

    services.clear();
    paiChartList.clear();

    final values = await _repo.getStatsService(
        prefUser.vetId!, fechaIn.text, fechaOut.text);
    services.addAll(values.result!.services!);

    for (var element in services) {
      final PieChartSectionData temp = PieChartSectionData(
        color: UniqueColorGenerator.getColor().withOpacity(0.7),
        value: element.value!.toDouble(),
        showTitle: false,
        radius: 25,
      );
      paiChartList.add(temp);
    }

    cargaServices.value = false;
  }

  getStatsDaily() => _getStatsDaily();
  Future<void> _getStatsDaily() async {
    cargaSalesDay.value = true;
    salesDay.clear();
    final values = await _repo.getStatsDaily(prefUser.vetId!);
    salesDay.addAll(values.result!.salesDay!);
    cargaSalesDay.value = false;
  }

  getStatsMonthly() => _getStatsMonthly();
  Future<void> _getStatsMonthly() async {
    cargaSalesMonth.value = true;
    salesMonth.clear();
    final values = await _repo.getStatsMonthly(prefUser.vetId!);

    salesMonth.addAll(values.result!.salesMonth!);
    cargaSalesMonth.value = false;
  }
}
