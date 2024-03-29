import 'dart:io';
import 'package:vet_app/src/establishments/data/model/data_map_model.dart';

import '_establishment_interface.dart';
import 'establishment_api.dart';
import 'model/establishment_model_lite.dart';
import 'model/establishmet.dart';
import 'model/service_model.dart';
import 'request/establishment_request.dart';
import 'request/price_est_request.dart';

class EstablishmentRepository extends EstablishmentInterface {
  final _api = EstablishmentApi();

  @override
  Future<void> deleteEstablishmetn(String establecimientoId) {
    return _api.deleteEstablishmetn(establecimientoId);
  }

  @override
  Future<List<EstablecimientoModelLite>?> getAll() {
    return _api.getAll();
  }

  @override
  Future<EstablishmentModal> getById(String idVet) {
    return _api.getById(idVet);
  }

  @override
  Future<EstablecimientoModelLite> getFirst() {
    return _api.getFirst();
  }

  @override
  Future<List<ServiceVetModel>> getServiceVet() {
    return _api.getServiceVet();
  }

  @override
  Future<String> setDescription(String establecimientoId, String description) {
    return _api.setDescription(establecimientoId, description);
  }

  @override
  Future<String> setEmployee(
      String establecimientoId, int typeId, String name, String code) {
    return _api.setEmployee(establecimientoId, typeId, name, code);
  }

  @override
  Future<String> setLogo(String establecimientoId, File image) {
    return _api.setLogo(establecimientoId, image);
  }

  @override
  Future<List> setNew(EstablecimientoEntity establecimiento) {
    return _api.setNew(establecimiento);
  }

  @override
  Future<String> setPrices(
      String establecimientoId, PriceEstablecimientoEntity precios) {
    return _api.setPrices(establecimientoId, precios);
  }

  @override
  Future<String> setSchedule(String establecimientoId, horarios) {
    return _api.setSchedule(establecimientoId, horarios);
  }

  @override
  Future<String> setSlides(String establecimientoId, File image) {
    return _api.setSlides(establecimientoId, image);
  }

  @override
  Future<String> updateBase(
      EstablecimientoEntity datosBase, String establecimientoId) {
    return _api.updateBase(datosBase, establecimientoId);
  }

  @override
  Future<DataMapModel> getLatLngByPlaceId(String placeId) {
    return _api.getLatLngByPlaceId(placeId);
  }

  @override
  Future<String> updateEmployee(String establecimientoId, String employeeId,
      int typeId, String name, String code) {
    return _api.updateEmployee(
      establecimientoId,
      employeeId,
      typeId,
      name,
      code,
    );
  }

  @override
  Future<String> deleteEmployee(String establecimientoId, String employeeId) {
    return _api.deleteEmployee(establecimientoId, employeeId);
  }

  @override
  Future<Employee> getEmployee(
    String establecimientoId,
    String employeeId,
  ) {
    return _api.getEmployee(establecimientoId, employeeId);
  }

  @override
  Future<List<Employee>> getAllEmployees(String establecimientoId) {
    return _api.getAllEmployees(establecimientoId);
  }

  @override
  Future<String> deleteSlide(String establecimientoId, String slide) {
    return _api.deleteSlide(establecimientoId, slide);
  }
}
