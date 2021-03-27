import 'dart:io';
import 'model/establishmentModelLite.dart';
import 'model/establishmet.dart';
import 'model/serviceModel.dart';
import 'request/establishmentRequest.dart';
import 'request/priceEstRequest.dart';

abstract class EstablishmentInterface {
  Future<List<ServiceVetModel>> getServiceVet();
  Future<List<dynamic>> setNew(EstablecimientoEntity establecimiento);
  Future<void> deleteEstablishmetn(String establecimientoId);
  Future<String> setEmployee(
    String establecimientoId,
    int typeId,
    String name,
    String code,
  );
  Future<String> setPrices(
    String establecimientoId,
    PriceEstablecimientoEntity precios,
  );
  Future<String> setSchedule(
    String establecimientoId,
    horarios,
  );
  Future<String> setDescription(
    String establecimientoId,
    String description,
  );
  Future<List<EstablecimientoModelLite>> getAll();
  Future<EstablecimientoModelLite> getFirst();
  Future<EstablishmentModal> getById(String idVet);
  Future<void> setLogo(String establecimientoId, File image);
}