import 'package:get/get.dart';
import 'package:vet_app/_supabase/auth/auth_repo.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/resources/utils/preferences/preferences_model.dart';
import 'package:vet_app/routes/routes.dart';
import 'package:vet_app/src/__global/domain/global_controller.dart';
import 'package:vet_app/src/establishments/data/establishment_repository.dart';
import 'package:vet_app/src/establishments/data/model/establishment_model_lite.dart';
import 'package:vet_app/src/establishments/presentation/pages/_children/show/show_vet.dart';
import 'package:vet_app/src/home/domain/home_controller.dart';

class EstablishmentsController extends GetxController {
  final establishmentRepo = EstablishmentRepository();

  final _carga = true.obs;
  bool get carga => _carga.value;
  set carga(bool value) => _carga.value = value;

  RxList<EstablecimientoModelLite> establecimientos =
      <EstablecimientoModelLite>[].obs;

  @override
  void onInit() {
    getAll();

    super.onInit();
  }

  @override
  void refresh() => _refresh();
  Future<dynamic> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 2));
    getAll();
    return null;
  }

  void getAll() => _getAll();
  Future<void> _getAll() async {
    carga = true;
    establecimientos.clear();
    final lista = await establishmentRepo.getAll();
    establecimientos.addAll(lista ?? []);

    if (establecimientos.isNotEmpty) {
      prefUser.hasMenu = true;
    } else {
      prefUser.hasMenu = false;
    }
    carga = false;
  }

  void delete(String id) => _delete(id);
  Future<void> _delete(String id) async {
    await establishmentRepo.deleteEstablishmetn(id);
    getAll();
    if (prefUser.vetId == id) {
      if (establecimientos.isNotEmpty) {
        final VetStorage forStorage = VetStorage();
        forStorage.vetId = establecimientos.first.id;
        forStorage.vetName = establecimientos.first.name;
        forStorage.vetLogo = establecimientos.first.logo;

        AuthSupaRepo().getEstablishment(forStorage.vetId!, forStorage.vetName!);

        prefUser.vetData = vetStorageToJson(forStorage);
      } else {
        prefUser.vetDataDel();
        prefUser.vetIdSupaDel();
        prefUser.hasMenu = false;
      }
    }
  }

  void go2Show(String id) => _go2Show(id);
  void _go2Show(String id) {
    Get.to(ShowVetMain(), arguments: id);
  }

  void favoriteVet(String? id, String? name, String? logo) {
    favoriteMain(id, name, logo);
  }

  Future<void> favoriteVetToInit(String? id, String? name, String? logo) async {
    favoriteMain(id, name, logo); //TODO: revisar
    Get.offNamedUntil(NameRoutes.home, (route) => false);
  }

  void favoriteMain(String? id, String? name, String? logo) {
    prefUser.vetDataDel();
    prefUser.vetIdSupaDel();

    final VetStorage forStorage = VetStorage();
    forStorage.vetId = id;
    forStorage.vetName = name;
    forStorage.vetLogo = logo;

    prefUser.vetData = vetStorageToJson(forStorage);

    AuthSupaRepo().getEstablishment(forStorage.vetId!, forStorage.vetName!);

    Get.find<HomeController>().nameVet.value = name!;
    Get.find<GlobalController>().generalLoad();
  }
}
