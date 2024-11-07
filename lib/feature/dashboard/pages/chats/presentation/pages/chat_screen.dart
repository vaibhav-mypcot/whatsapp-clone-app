import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_app/core/common/enum/message_enum.dart';
import 'package:whatsapp_clone_app/core/common/widgets/common_app_bar.dart';
import 'package:whatsapp_clone_app/core/common/widgets/loader_widget.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/message_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/user_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/bottom_chat_field.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/chat_list.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/my_message_card.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/sender_message_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.reciverUserId,
    required this.name,
    required this.imageUrl,
  });

  final String reciverUserId;
  final String name;
  final String imageUrl;

  static const String route = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  @override
  Widget build(BuildContext context) {
    // -- Date format
    var now = DateTime.now();
    var formattedTime = DateFormat('hh:mm a').format(now);

    // -- Checking local device is Dark
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff0A1B23) : const Color(0xffE5DDD5),
      appBar: CommonAppBar(
        title: widget.name,
        getBack: () => Navigator.pop(context),
        profilePics: widget.imageUrl,
        icons: const [Icons.videocam, Icons.call],
        onClick: () {
          // Get.toNamed(AppRoutes.profileScreen);
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ChatList(
                reciverUserId: widget.reciverUserId,
                isDark: isDarkMode,
              ),
            ),

            // -- Textfield to type messages
            // SizedBox(height: 6.h),
            BottomChatField(
              isDarkMode: isDarkMode,
              reciverUserId: widget.reciverUserId,
            ),
          ],
        ),
      ),
    );
  }
}
