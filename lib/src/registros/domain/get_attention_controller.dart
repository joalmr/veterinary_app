import 'package:get/get.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/src/_pet/data/model/pet_client.dart';
import 'package:vet_app/src/_pet/data/pet_repository.dart';
import 'package:vet_app/src/registros/data/attentions_repository.dart';
import 'package:vet_app/src/registros/data/model/attention_detail_model.dart';

class GetAttentionsController extends GetxController {
  final _repo = AttentionRepository();
  final _repoPet = PetClientRepository();

  final petData = Rxn<PetClient>();
  final attention = AttentionDetailModel().obs;
  // final petHistory = PetClientHistory().obs;

  final loadingPage = true.obs;

  @override
  Future<void> onInit() async {
    attention.value = await _repo.getAttentionDetail(
      prefUser.vetId!,
      Get.arguments.toString(),
    );

    petData.value = await _repoPet.getPet(attention.value.result!.petId!);
    
    loadingPage.value = false;

    super.onInit();
  }
}
