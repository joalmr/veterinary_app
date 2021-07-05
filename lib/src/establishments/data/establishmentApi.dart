import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vet_app/resources/utils/header_http.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/src/establishments/data/model/dataMapModel.dart';
import 'package:vet_app/src/establishments/data/model/establishmentModelLite.dart';
import 'package:vet_app/src/establishments/data/model/serviceModel.dart';
import '_establishmentInterface.dart';
import 'model/establishmet.dart';
import 'request/establishmentRequest.dart';
import 'request/priceEstRequest.dart';

class EstablishmentApi extends EstablishmentInterface {
  @override
  Future<List<EstablecimientoModelLite>> getAll() async {
    final url = Uri.https(urlBase!, '$pathBase/establishments');
    final http.Response response = await http.get(url, headers: headersToken());
    final establecimientos = establecimientoModelLiteFromJson(response.body);
    return establecimientos;
  }

  @override
  Future<EstablishmentModal> getById(String idVet) async {
    final url = Uri.https(urlBase!, '$pathBase/establishment/$idVet');
    final http.Response response = await http.get(url, headers: headersToken());

    final EstablishmentModal establecimiento =
        EstablishmentModal.fromJson(json.decode(response.body));

    return establecimiento;
  }

  @override
  Future<EstablecimientoModelLite> getFirst() async {
    final url = Uri.https(urlBase!, '$pathBase/establishments');
    final http.Response response = await http.get(url, headers: headersToken());

    final establecimientos = establecimientoModelLiteFromJson(response.body);
    return establecimientos.first;
  }

  @override
  Future<List<ServiceVetModel>> getServiceVet() async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/services',
    );

    final http.Response response = await http.get(
      url,
      headers: headersToken(),
    );

    var data = serviceVetModelFromJson(response.body);

    return data;
  }

  @override
  Future<List<dynamic>> setNew(EstablecimientoEntity establecimiento) async {
    final url = Uri.https(urlBase!, '$pathBase/establishment');
    var lista = [];

    http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(establecimiento),
    );

    final data = jsonDecode(response.body);

    lista.add(response.statusCode);
    lista.add(data['id']);

    return lista;
  }

  @override
  Future<String> setEmployee(
      String establecimientoId, int typeId, String name, String code) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/employee',
    );

    final employee = {
      'type_id': typeId,
      'name': name,
      'code': code,
    };

    http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(employee),
    );

    final data = jsonDecode(response.body);

    print(data);
    return 'asd';
  }

  //? obtener empleados
  @override
  Future<List<Employee>> getAllEmployees(String establecimientoId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/employees',
    );

    http.Response response = await http.get(
      url,
      headers: headersToken(),
    );
    final List<Employee> data = List<Employee>.from(
        json.decode(response.body).map((x) => Employee.fromJson(x)));

    return data;
  }

  //? obtener empleado
  @override
  Future<Employee> getEmployee(
      String establecimientoId, String employeeId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/employee/$employeeId',
    );

    http.Response response = await http.get(
      url,
      headers: headersToken(),
    );

    final data = Employee.fromJson(jsonDecode(response.body));

    return data;
  }

  //? actualiza empleado
  @override
  Future<String> updateEmployee(String establecimientoId, String employeeId,
      int typeId, String name, String code) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/employee',
    );

    final employee = {
      'employee_id': employeeId,
      'type_id': typeId,
      'name': name,
      'code': code,
    };

    http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(employee),
    );

    final data = jsonDecode(response.body);

    print(data);
    return response.statusCode.toString();
  }

  //? elimina empleado
  @override
  Future<String> deleteEmployee(
      String establecimientoId, String employeeId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/employee/$employeeId',
    );

    http.Response response = await http.delete(
      url,
      headers: headersToken(),
    );

    final data = jsonDecode(response.body);

    print(data);
    return 'asd';
  }

  @override
  Future<String> setPrices(
    String establecimientoId,
    PriceEstablecimientoEntity precios,
  ) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/prices',
    );

    http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(precios),
    );

    final data = jsonDecode(response.body);

    print(data);
    return 'asd';
  }

  @override
  Future<String> setSchedule(String establecimientoId, horarios) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/schedule',
    );

    http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(horarios),
    );

    final data = jsonDecode(response.body);

    print(data);
    return 'asd';
  }

  @override
  Future<String> setDescription(
    String establecimientoId,
    String description,
  ) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/description',
    );

    final descriptionData = {
      'description': description,
    };
    final http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(descriptionData),
    );

    final data = jsonDecode(response.body);

    print(data);
    return 'asd';
  }

  @override
  Future<void> deleteEstablishmetn(String establecimientoId) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId',
    );

    final http.Response response = await http.delete(
      url,
      headers: headersToken(),
    );

    var data = jsonDecode(response.body);
    print(data);
  }

  @override
  Future<String> setLogo(String establecimientoId, File image) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/logo',
    );

    var request = http.MultipartRequest('POST', url);
    var pic = await http.MultipartFile.fromPath('logo', image.path);

    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    request.headers['Authorization'] = 'Bearer ${prefUser.token}';
    request.headers['X-Requested-With'] = 'XMLHttpRequest';

    request.files.add(pic);
    final response = await request.send();

    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);

    final dato = jsonDecode(responseString);

    return dato['logo'] as String;
  }

  @override
  Future<String> setSlides(String establecimientoId, File image) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/slide',
    );

    final request = http.MultipartRequest('POST', url);
    final pic = await http.MultipartFile.fromPath('slide', image.path);

    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    request.headers['Authorization'] = 'Bearer ${prefUser.token}';
    request.headers['X-Requested-With'] = 'XMLHttpRequest';

    request.files.add(pic);
    final response = await request.send();

    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);

    final dato = jsonDecode(responseString);
    print(dato);
    return 'slide ok';
  }

  @override
  Future<String> updateBase(
      EstablecimientoEntity datosBase, String establecimientoId) async {
    final url =
        Uri.https(urlBase!, '$pathBase/establishment/$establecimientoId');

    final http.Response response = await http.post(
      url,
      headers: headersToken(),
      body: jsonEncode(datosBase),
    );

    final data = jsonDecode(response.body);
    print(data);
    return response.statusCode.toString();
  }

  @override
  Future<DataMapModel> getLatLngByPlaceId(String placeId) async {
    const _urlBase = 'maps.googleapis.com';
    final url = Uri.https(
      _urlBase,
      '/maps/api/place/details/json',
      {
        'key': keyMap,
        'language': 'es',
        'placeid': placeId,
      },
    );

    final http.Response response = await http.get(url);

    final byPlaceId = dataMapModelFromJson(response.body);

    return byPlaceId;
  }

  @override
  Future<String> deleteSlide(String establecimientoId, String slide) async {
    final url = Uri.https(
      urlBase!,
      '$pathBase/establishment/$establecimientoId/slide',
    );

    final jsonData = {
      'slide': slide,
    };

    final http.Response response = await http.delete(
      url,
      headers: headersToken(),
      body: jsonEncode(jsonData),
    );

    final data = jsonDecode(response.body);

    print(data);
    return 'asd';
  }
}
