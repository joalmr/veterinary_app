import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/establishments/data/establishmentRepository.dart';
import 'package:vet_app/src/establishments/data/request/priceEstRequest.dart';
import 'package:vet_app/src/establishments/domain/show/showVetController.dart';

class EditPricesController extends GetxController {
  final _repo = EstablishmentRepository();

  final showVetController = Get.find<ShowVetController>();

  final consultaControl = new MoneyMaskedTextController(
    initialValue: 0,
    decimalSeparator: '.',
    thousandSeparator: ',',
    precision: 2,
    leftSymbol: 'S/ ',
  );
  final desparasitaControl = new MoneyMaskedTextController(
    initialValue: 0,
    decimalSeparator: '.',
    thousandSeparator: ',',
    precision: 2,
    leftSymbol: 'S/ ',
  );
  final vacunaControl = new MoneyMaskedTextController(
    initialValue: 0,
    decimalSeparator: '.',
    thousandSeparator: ',',
    precision: 2,
    leftSymbol: 'S/ ',
  );
  final groomingControl = new MoneyMaskedTextController(
    initialValue: 0,
    decimalSeparator: '.',
    thousandSeparator: ',',
    precision: 2,
    leftSymbol: 'S/ ',
  );

  PriceEstablecimientoEntity prices = new PriceEstablecimientoEntity();

  @override
  void onInit() {
    consultaControl.text = double.parse(
            showVetController.establishment.value.prices.consultation.from)
        .toStringAsFixed(2);
    desparasitaControl.text = double.parse(
            showVetController.establishment.value.prices.deworming.from)
        .toStringAsFixed(2);
    vacunaControl.text = double.parse(
            showVetController.establishment.value.prices.vaccination.from)
        .toStringAsFixed(2);
    groomingControl.text =
        double.parse(showVetController.establishment.value.prices.grooming.from)
            .toStringAsFixed(2);
    super.onInit();
  }

  editPrecios() => _editPrices();
  _editPrices() async {
    prices.consultationPriceFrom = consultaControl.numberValue;
    prices.dewormingPriceFrom = desparasitaControl.numberValue;
    prices.groomingPriceFrom = groomingControl.numberValue;
    prices.vaccinationPriceFrom = vacunaControl.numberValue;
    await _repo.setPrices(showVetController.argumentoId, prices);

    showVetController.getByid();
    showVetController.initialTab.value = 2;
    Get.back();
  }
}