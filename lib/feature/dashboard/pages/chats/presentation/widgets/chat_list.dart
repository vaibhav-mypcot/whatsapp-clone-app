// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/message_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/my_message_card.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/sender_message_card.dart';

class ChatList extends StatefulWidget {
  const ChatList({
    Key? key,
    required this.reciverUserId,
    required this.isDark,
  }) : super(key: key);
  final String reciverUserId;
  final bool isDark;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Stream<List<Message>> getChatStream(String reciverUserId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(reciverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(
          Message.fromMap(
            document.data(),
          ),
        );
      }
      return messages;
    });
  }

  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: getChatStream(widget.reciverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
              // reverse: true,
              controller: messageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                var timeSent = DateFormat.Hm().format(messageData.timeSent);
                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  print("my msg card type: ${messageData.type}");
                  return MyMessageCard(
                    message: messageData.text,
                    date: timeSent,
                    isDark: widget.isDark,
                    type: messageData.type,
                  );
                }
                return SenderMessageCard(
                  message: messageData.text,
                  date: timeSent,
                  isDark: widget.isDark,
                  type: messageData.type,
                );
              });
        });
  }
}
