import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/chat/domain/chat_controller.dart';

class MessagesView extends StatelessWidget {
  final mensaje = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetX<ChatController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: Column(
            children: [
              Expanded(
                child: _.mensajes.isEmpty
                    ? const Icon(Icons.chat_bubble_outline_rounded)
                    : ListView.builder(
                        itemCount: _.mensajes.length,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        itemBuilder: (BuildContext context, int index) {
                          final message = _.mensajes[index];
                          return Container(
                            margin: message.type!
                                ? const EdgeInsets.only(
                                    left: 15, top: 5, bottom: 5, right: 5)
                                : const EdgeInsets.only(
                                    right: 15, top: 5, bottom: 5, left: 5),
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, bottom: 2.5, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: !message.type!
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25))
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                color: !message.type!
                                    ? colorMain.withOpacity(0.5)
                                    : colorBlue.withOpacity(0.5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.message!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.5),
                                  child: Align(
                                    alignment: message.type!
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                    child: Text(
                                      message.sendAt.toString().split(' ')[0],
                                      style: const TextStyle(fontSize: 8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mensaje,
                  decoration: InputDecoration(
                      suffix: TextButton(
                    onPressed: () {
                      if (mensaje.text.trim() != '') {
                        _.addMessage(mensaje.text);
                        mensaje.text = '';
                      }
                    },
                    child: const Text('Enviar'),
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
