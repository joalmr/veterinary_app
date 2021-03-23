import 'package:get/get.dart';
import 'package:vet_app/src/establishments/data/model/establishmentModelLite.dart';
import 'package:vet_app/src/establishments/data/model/establishmet.dart';

class EstablishmentValue {
  RxBool _carga = true.obs;
  bool get carga => _carga.value;
  set carga(bool value) => _carga.value = value;

  RxList<EstablecimientoModelLite> establecimientos =
      <EstablecimientoModelLite>[].obs;

  EstablishmentModal establishment;
}