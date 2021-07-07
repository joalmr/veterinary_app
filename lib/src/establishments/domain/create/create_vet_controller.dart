import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/utils/days/dia_semana.dart';
import 'package:vet_app/routes/routes.dart';
import 'package:vet_app/src/establishments/data/establishment_repository.dart';
import 'package:vet_app/src/establishments/data/model/prediction.dart';
import 'package:vet_app/src/establishments/data/model/service_model.dart';
import 'package:vet_app/src/establishments/data/request/establishment_request.dart';
import 'package:vet_app/src/establishments/data/request/price_est_request.dart';

import '../establishments_controller.dart';
import 'create_vet_value.dart';

class CreateVetController extends GetxController {
  final _repo = EstablishmentRepository();
  final v = CreateVetValue();

  EstablecimientoEntity entity = EstablecimientoEntity();
  PriceEstablecimientoEntity prices = PriceEstablecimientoEntity();

  final vetController = Get.find<EstablishmentsController>();

  final _checked = false.obs;
  bool get checked => _checked.value;
  set checked(bool value) => _checked.value = value;

  final _idVet = ''.obs;
  String get idVet => _idVet.value;
  set idVet(String value) => _idVet.value = value;

  final _selected = 1.obs;
  int get selected => _selected.value;
  set selected(int value) => _selected.value = value;

  final _description = ''.obs;
  String get description => _description.value;
  set description(String value) => _description.value = value;

  final RxString _vetType = '1'.obs;
  String get vetType => _vetType.value;
  set vetType(String value) => _vetType.value = value;

  final RxString _personalType = '2'.obs;
  String get personalType => _personalType.value;
  set personalType(String value) => _personalType.value = value;

  final servicesVet = <ServiceVetModel>[].obs;
  final servicesVetSet = <int>[].obs;

  final errorDays = <String>[].obs;

  final marcador = <Marker>[].obs;

  String? _mapStyle;
  GoogleMapController? _controller;

  String displayStringForOption(Prediction option) => option.name!;

  @override
  void onInit() {
    super.onInit();
    _getService();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  _getService() async {
    final lista = await _repo.getServiceVet();
    servicesVet.clear();
    servicesVet.addAll(lista);
  }

  mapCreated(GoogleMapController? controller) {
    _controller = controller;
    _controller!.setMapStyle(_mapStyle);
  }

  void add2List(int numero) {
    if (!servicesVetSet.contains(numero)) {
      servicesVetSet.add(numero);
    } else {
      if (servicesVetSet.length > 1) {
        servicesVetSet.remove(numero);
      }
    }
  }

  // buscaDireccion(String filter)=>_buscaDireccion(filter);
  // _buscaDireccion(String filter) async {
  //   print(filter);
  //   String ruta =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$keyMap&language=es&input=$filter';
  //   Uri url = Uri.parse(ruta);
  //   var response = await http.get(url);
  //   print(response.body);
  //   var models = addressFromJson(response.body);
  //   return models.predictions;
  // }

  gpsDireccion(Prediction data) {
    _searchandNavigate(data);
  }

  double? lat; //-12.045645176850693, -77.03056366799036
  double? lng;

  _searchandNavigate(Prediction dato) async {
    if (v.dirVet.text.trim() != '') {
      marcador.clear();

      v.dirVet.text = dato.name!;
      entity.address = dato.name;

      final datoById = await _repo.getLatLngByPlaceId(dato.placeId!);
      final location = datoById.result!.geometry!.location;
      lat = location!.lat;
      lng = location.lng;
      final latlng = LatLng(location.lat!, location.lng!);

      marcador.add(
        Marker(
          markerId: const MarkerId('1'),
          position: latlng,
          draggable: true,
          onDragEnd: ((LatLng value) {
            lat = value.latitude;
            lng = value.longitude;
          }),
        ),
      );
      update(['xmap']);
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latlng,
            zoom: 16.0,
            bearing: 45.0,
            tilt: 45.0,
          ),
        ),
      );
    }
  }

  _newEstablishment() async {
    entity.typeId = int.parse(vetType);
    entity.latitude = lat;
    entity.longitude = lng;
    entity.services = servicesVetSet;
    entity.reference = '';

    // var resp =
    _repo.setNew(entity).then((value) async {
      if (value[0] != 200) {
        Get.snackbar(
          'Error',
          'No se creó el establecimiento',
          backgroundColor: colorRed,
          colorText: colorWhite,
        );
      } else {
        idVet = value[1];
        await _setEmployee(idVet);
        await _setSchedule(idVet);
        await _setPrices(idVet);
        await _setDescription(idVet);
        vetController.getAll();
      }
    });
  }

  _setEmployee(String idVeterinaria) async {
    final int type = int.parse(personalType);
    final String name = v.personalNameVet.text;
    final String code = v.personalCodeVet.text;
    await _repo.setEmployee(idVeterinaria, type, name, code);
  }

  _setPrices(String idVeterinaria) async {
    prices.consultationPriceFrom = v.moneyConsulta.numberValue;
    prices.dewormingPriceFrom = v.moneyDesparasita.numberValue;
    prices.groomingPriceFrom = v.moneyGrooming.numberValue;
    prices.vaccinationPriceFrom = v.moneyVacuna.numberValue;

    await _repo.setPrices(idVeterinaria, prices);
  }

  _setSchedule(String idVeterinaria) async {
    final schedule = {
      'monday': {
        'switch': v.checkDay[0],
        'time_start': v.iniDay[0],
        'time_end': v.endDay[0],
      },
      'tuesday': {
        'switch': v.checkDay[1],
        'time_start': v.iniDay[1],
        'time_end': v.endDay[1],
      },
      'wednesday': {
        'switch': v.checkDay[2],
        'time_start': v.iniDay[2],
        'time_end': v.endDay[2],
      },
      'thursday': {
        'switch': v.checkDay[3],
        'time_start': v.iniDay[3],
        'time_end': v.endDay[3],
      },
      'friday': {
        'switch': v.checkDay[4],
        'time_start': v.iniDay[4],
        'time_end': v.endDay[4],
      },
      'saturday': {
        'switch': v.checkDay[5],
        'time_start': v.iniDay[5],
        'time_end': v.endDay[5],
      },
      'sunday': {
        'switch': v.checkDay[6],
        'time_start': v.iniDay[6],
        'time_end': v.endDay[6],
      },
    };

    await _repo.setSchedule(idVeterinaria, schedule);
  }

  _setDescription(String idVeterinaria) async {
    await _repo.setDescription(idVeterinaria, description);
  }

  setFinaliza() => _newEstablishment();

  //step 1
  bool get ename => v.nameVet.text.isEmpty;
  bool get ephone => v.phoneVet.text.isEmpty;
  bool get eruc => v.rucVet.text.isEmpty;
  bool get eweb => v.webVet.text.isEmpty;
  bool get eservices => servicesVetSet.isEmpty;
  //step 2
  bool get edirVet => v.dirVet.text.isEmpty;
  //step 3
  bool get epersonalNameVet => v.personalNameVet.text.isEmpty;
  bool get epersonalCodeVet =>
      v.personalCodeVet.text.isEmpty && personalType == '2';
  bool get emoneyConsulta => v.moneyConsulta.text.isEmpty;
  bool get emoneyDesparasita => v.moneyDesparasita.text.isEmpty;
  bool get emoneyVacuna => v.moneyVacuna.text.isEmpty;
  bool get emoneyGrooming => v.moneyGrooming.text.isEmpty;
  //step 4
  bool get edescriptionVet => v.descriptionVet.text.isEmpty;

  validaStep1() {
    if (ename || ephone || eruc || eweb || eservices) {
      Get.snackbar(
        'Error',
        'Llene todos los campos',
        backgroundColor: colorRed,
        colorText: colorWhite,
      );
    } else {
      if (selected < 4) selected++;
    }
  }

  validaStep2() {
    if (edirVet) {
      Get.snackbar(
        'Error',
        'Llene los campos',
        backgroundColor: colorRed,
        colorText: colorWhite,
      );
    } else {
      if (selected < 4) selected++;
    }
  }

  validaStep3() {
    var diaError = '';
    var diaHoraError = '';
    for (var i = 0; i < 7; i++) {
      final String ini = v.iniController[i].text;
      final String end = v.endController[i].text;
      if (v.checkDay[i]) {
        if (ini.isEmpty || end.isEmpty) {
          diaError == ''
              ? diaError = diaError + diaSemana[i]
              : diaError = '$diaError, ${diaSemana[i]}';
        } else {
          final int iniNum = int.parse(ini.split(':')[0]);
          final int endNum = int.parse(end.split(':')[0]);
          if (iniNum >= endNum) {
            diaHoraError =
                '''Hora seleccionada incorrecta el día ${diaSemana[i]}, la hora de inicio es mayor a la de fin''';
          }
        }
      }
    }

    if (emoneyConsulta ||
        emoneyDesparasita ||
        emoneyVacuna ||
        emoneyGrooming ||
        epersonalNameVet ||
        epersonalCodeVet) {
      Get.snackbar(
        'Error',
        'Llene los campos',
        backgroundColor: colorRed,
        colorText: colorWhite,
      );
    } else if (diaError != '' || diaHoraError != '') {
      if (diaError != '') {
        Get.snackbar(
          'Error',
          'Complete los datos de $diaError',
          backgroundColor: colorRed,
          colorText: colorWhite,
        );
      }
      if (diaHoraError != '') {
        Get.snackbar(
          'Error',
          diaHoraError,
          backgroundColor: colorRed,
          colorText: colorWhite,
        );
      }
    } else {
      if (selected < 4) selected++;
    }
  }

  validaStep4() {
    if (edescriptionVet) {
      Get.snackbar(
        'Error',
        'Llene los campos',
        backgroundColor: colorRed,
        colorText: colorWhite,
      );
    } else {
      checked = true;
      setFinaliza();
      Timer(
        const Duration(milliseconds: 3500),
        () {
          checked = false;
          Get.offNamed(NameRoutes.establishments);
        },
      );
    }
  }
}