import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/__global/domain/global_controller.dart';
import 'package:vet_app/src/establishments/data/establishment_repository.dart';
import 'package:vet_app/src/establishments/data/model/prediction.dart';
import 'package:vet_app/src/establishments/data/request/establishment_request.dart';
import 'package:vet_app/src/establishments/domain/show/show_vet_controller.dart';

class EditBaseController extends GetxController {
  final _repo = EstablishmentRepository();

  final nameControl = TextEditingController();
  final phoneControl = TextEditingController();
  final addressControl = TextEditingController();

  final showVetController = Get.find<ShowVetController>();
  final _global = Get.find<GlobalController>();
  // final vetController = Get.find<EstablishmentsController>();

  final _vetTypeId = ''.obs;
  String get vetTypeId => _vetTypeId.value;
  set vetTypeId(String value) => _vetTypeId.value = value;

  final entityBase = EstablecimientoEntity().obs;

  List<int> services = [];

  @override
  void onInit() {
    vetTypeId = showVetController.establishment.value.typeId.toString();
    nameControl.text = showVetController.establishment.value.name!;
    addressControl.text = showVetController.establishment.value.address!;
    phoneControl.text = showVetController.establishment.value.phone!;

    for (var element in showVetController.establishment.value.services!) {
      services.add(element.id!);
    }

    entityBase.update((val) {
      val!.name = showVetController.establishment.value.name;
      val.phone = showVetController.establishment.value.phone;
      val.ruc = showVetController.establishment.value.ruc;
      val.website = showVetController.establishment.value.website;
      val.typeId = showVetController.establishment.value.typeId;
      val.address = showVetController.establishment.value.address;
      val.reference = showVetController.establishment.value.reference;
      val.latitude = showVetController.establishment.value.latitude;
      val.longitude = showVetController.establishment.value.longitude;
      val.services = services;
    });

    super.onInit();
  }

  void updateBase() => _updateBase();

  _updateBase() async {
    entityBase.update((val) {
      val!.name = nameControl.text;
      val.phone = phoneControl.text;
      val.address = addressControl.text;
      val.typeId = int.parse(vetTypeId);
    });

    await _repo.updateBase(
        entityBase.value, showVetController.argumentoId.value);

    showVetController.getByid();
    _global.generalLoad();
    // vetController.getAll();
    Get.back();
  }

  gpsDireccion(Prediction data) {
    _searchandNavigate(data);
  }

  Future<void> _searchandNavigate(Prediction dato) async {
    if (addressControl.text.trim() != '') {
      addressControl.text = dato.name!;

      final datoById = await _repo.getLatLngByPlaceId(dato.placeId!);
      final location = datoById.result!.geometry!.location;

      entityBase.update((val) {
        val!.latitude = location!.lat;
        val.longitude = location.lng;
      });
    }
  }
}
