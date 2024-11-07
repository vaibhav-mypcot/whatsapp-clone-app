import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_app/core/common/widgets/loader_widget.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chat_contact/data/model/chat_contact_model.dart';

import 'package:whatsapp_clone_app/feature/dashboard/pages/chat_contact/presentation/widget/feed_tile.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/user_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/pages/chat_screen.dart';
import 'package:whatsapp_clone_app/sample_data/feed_data_list.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  Stream<List<ChatContactModel>> getChatContact() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap(
      (event) async {
        List<ChatContactModel> contacts = [];

        for (var document in event.docs) {
          var chatContact = ChatContactModel.fromMap(document.data());

          var userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(chatContact.contactId)
              .get();

          print("Chat contact id: ${chatContact.contactId}");

          var user = UserModel.fromMap(userData.data()!);

          print("user naem: ${user.name}");
          print("user profile: ${user.profilePic}");
          contacts.add(
            ChatContactModel(
              name: user.name,
              profilePic: user.profilePic,
              contactId: chatContact.contactId,
              lastMessage: chatContact.lastMessage,
              timeSent: chatContact.timeSent,
            ),
          );
        }
        return contacts;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: StreamBuilder<List<ChatContactModel>>(
          stream: getChatContact(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var chatContactData = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    print("clicked");
                    // Get.toNamed(AppRoutes.chatScreen, arguments: index);
                    print("clicked index: ${index} ");
                    Navigator.pushNamed(
                      context,
                      ChatScreen.route,
                      arguments: {
                        // TODO: pass the name also
                        'receiverId': chatContactData.contactId,
                        'name': chatContactData.name,
                        'imageUrl': chatContactData.profilePic,
                      },
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: FeedTile(
                      profilePic: chatContactData.profilePic,
                      name: chatContactData.name,
                      date: DateFormat('hh:mm a')
                          .format(chatContactData.timeSent),
                      status: chatContactData.lastMessage,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
