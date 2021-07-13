import 'package:flutter/material.dart';
import 'package:vet_app/design/layout/main_layout.dart';
import 'package:vet_app/src/chat/presentation/app/chats_view.dart';

class ChatsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ChatsView(),
    );
  }
}
