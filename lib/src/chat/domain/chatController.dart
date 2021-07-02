import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:vet_app/_supabase/chatRepo.dart';
import 'package:vet_app/_supabase/model/canalModel.dart';
import 'package:vet_app/_supabase/model/messageModel.dart';
import 'package:vet_app/config/variablesSupabase.dart';
import 'package:vet_app/config/variablesGlobal.dart';
import 'package:vet_app/src/chat/presentation/messageView.dart';

class ChatController extends GetxController {
  final _repo = ChatRepo();

  RxBool cargando = true.obs;
  RxList<CanalModel> chats = <CanalModel>[].obs;
  RxList<MessageModel> mensajes = <MessageModel>[].obs;

  int? vetInt;
  int? canalId;

  RealtimeSubscription? subscriptionMessage;
  final supabaseClient = SupabaseClient(urlSupa!, keySupa!);

  @override
  Future<void> onInit() async {
    super.onInit();

    vetInt = await _repo.getEstablishment(prefUser.vetId!, prefUser.vetName!);
    
    runSubscription();

    await getChats();
    cargando.value = false;
    
  }

  getChats() => _getChats();
  _getChats() async {
    final response = await _repo.getCanal(vetInt!);

    chats.clear();
    chats.addAll(response);
  }

  goToMessage(int canal) {
    Get.to(MessagesView());
    _getMessage(canal);
  }

  _getMessage(int canal) async {
    canalId = canal;
    final response = await _repo.getMessages(canal);

    mensajes.clear();
    mensajes.addAll(response);
  }

  addMessage(String message) => _addMessage(message);
  _addMessage(String message) async {
    await _repo.addMessage(canalId!, message);
  }

  void runSubscription() {
    //TODO: revisar si funciona especifico
    subscriptionMessage = supabaseClient
    .from('message')//:canal_id=eq.$canalId'
    .on(SupabaseEventTypes.delete, (payload) {
      _getMessage(canalId!);
    })
    .on(SupabaseEventTypes.update, (payload) {
      _getMessage(canalId!);
    }).on(SupabaseEventTypes.insert, (payload) {
      _getMessage(canalId!);
    }).subscribe();


    subscriptionMessage = supabaseClient
    .from('canal')//:establishment_id=eq.$vetInt
    .on(SupabaseEventTypes.delete, (payload) {
      getChats();
    })
    .on(SupabaseEventTypes.update, (payload) {
      getChats();
    }).on(SupabaseEventTypes.insert, (payload) {
      getChats();
    }).subscribe();
  }
}
