import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone_app/core/common/enum/message_enum.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chat_contact/data/model/chat_contact_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/message_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/user_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

var uid = FirebaseAuth.instance.currentUser?.uid;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  File? pickedImageFile;

  ChatBloc() : super(ChatInitial()) {
    on<SendTextMessageEvent>(_onSendTextMessageEvent);
    on<SendImageMessageEvent>(_onSendImageMessageEvent);
    on<SendVideoEvent>(_onSendVideoEvent);
    on<SendAudioEvent>(_onSendAudioEvent);
  }

  _onSendTextMessageEvent(
      SendTextMessageEvent event, Emitter<ChatState> emit) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;

      final currentUserData = await getCurrentUserData();

      var userDataMap = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.reciverUserId)
          .get();

      print("reciver user id: ${event.reciverUserId}");

      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v4();

      _saveDataToContactsSubcollection(
        currentUserData!,
        recieverUserData,
        event.message,
        timeSent,
        event.reciverUserId,
      );

      _saveMessageToContactsSubcollection(
        recieverUserId: event.reciverUserId,
        text: event.message,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        userName: currentUserData.name,
        reciverUserName: recieverUserData.name,
      );
    } catch (e) {
      print(e);
    }
  }

// -- select image form gallary --

  _onSendImageMessageEvent(
      SendImageMessageEvent event, Emitter<ChatState> emit) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageTemp = XFile(image.path);
      pickedImageFile = File(imageTemp.path);
    }

    final senderUserData = await getCurrentUserData();

    sendFileMessage(
      file: pickedImageFile!,
      recieverUserId: event.reciverUserId,
      senderUserData: senderUserData!,
      messageEnum: event.msgEnum,
    );
  }

  // send audio file

  _onSendAudioEvent(SendAudioEvent event, Emitter<ChatState> emit) async {
        final senderUserData = await getCurrentUserData();


    sendFileMessage(
      file: event.file,
      recieverUserId: event.reciverUserId,
      senderUserData: senderUserData!,
      messageEnum: event.msgEnum,
    );
  }

  _onSendVideoEvent(SendVideoEvent event, Emitter<ChatState> emit) async {
    File? video;

    final senderUserData = await getCurrentUserData();

    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
      sendFileMessage(
        file: video,
        recieverUserId: event.reciverUserId,
        senderUserData: senderUserData!,
        messageEnum: event.msgEnum,
      );
    }
  }
}

void _saveDataToContactsSubcollection(
  UserModel senderUserData,
  UserModel recieverUserData,
  String text,
  DateTime timeSent,
  String receiverUserId,
) async {
  // users -> reciver user id -> chats -> current user id -> set data
  var receiverChatContact = ChatContactModel(
    name: senderUserData.name,
    profilePic: senderUserData.profilePic,
    contactId: senderUserData.uid,
    timeSent: timeSent,
    lastMessage: text,
  );

  await FirebaseFirestore.instance
      .collection('users')
      .doc(receiverUserId)
      .collection('chats')
      .doc(uid)
      .set(receiverChatContact.toMap());

  // users -> current user id -> chats -> reciver user id -> set data

  var senderChatContact = ChatContactModel(
    name: recieverUserData.name,
    profilePic: recieverUserData.profilePic,
    contactId: recieverUserData.uid,
    timeSent: timeSent,
    lastMessage: text,
  );

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats')
      .doc(receiverUserId)
      .set(
        senderChatContact.toMap(),
      );
}

void _saveMessageToContactsSubcollection({
  required String recieverUserId,
  required String text,
  required DateTime timeSent,
  required String messageId,
  required String userName,
  required reciverUserName,
  required MessageEnum messageType,
}) async {
  final message = Message(
    senderId: uid!,
    recieverid: recieverUserId,
    text: text,
    type: messageType,
    timeSent: timeSent,
    messageId: messageId,
    isSeen: false,
  );

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats')
      .doc(recieverUserId)
      .collection('messages')
      .doc(messageId)
      .set(
        message.toMap(),
      );

  await FirebaseFirestore.instance
      .collection('users')
      .doc(recieverUserId)
      .collection('chats')
      .doc(uid)
      .collection('messages')
      .doc(messageId)
      .set(
        message.toMap(),
      );
}

Future<UserModel?> getCurrentUserData() async {
  var userData =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

  UserModel? user;
  if (userData.data() != null) {
    user = UserModel.fromMap(userData.data()!);
  }
  return user;
}

void sendFileMessage({
  required File file,
  required String recieverUserId,
  required UserModel senderUserData,
  required MessageEnum messageEnum,
}) async {
  try {
    var timeSent = DateTime.now();
    var messageId = const Uuid().v4();

    String imageUrl = await storeFileToFirebase(
      'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
      file,
    );

    UserModel receiverUserData;

    var userDataMap = await FirebaseFirestore.instance
        .collection('users')
        .doc(recieverUserId)
        .get();

    receiverUserData = UserModel.fromMap(userDataMap.data()!);

    String contactMsg;

    switch (messageEnum) {
      case MessageEnum.image:
        contactMsg = '📷 Photo';
        break;
      case MessageEnum.video:
        contactMsg = '📽️ Video';
        break;
      case MessageEnum.audio:
        contactMsg = '🎶 Audio';
        break;
      case MessageEnum.gif:
        contactMsg = '🧧 GIf';
        break;
      default:
        contactMsg = 'GIF';
    }

    _saveDataToContactsSubcollection(
      senderUserData,
      receiverUserData,
      contactMsg,
      timeSent,
      recieverUserId,
    );

    _saveMessageToContactsSubcollection(
      recieverUserId: recieverUserId,
      text: imageUrl,
      timeSent: timeSent,
      messageId: messageId,
      userName: senderUserData.name,
      reciverUserName: receiverUserData.name,
      messageType: messageEnum,
    );
  } catch (e) {
    print(e);
  }
}

Future<String> storeFileToFirebase(String ref, File file) async {
  // Determine the MIME type of the file (e.g., 'image/jpeg', 'video/mp4')
  String? mimeType = lookupMimeType(file.path);

  // Set metadata with the determined MIME type
  SettableMetadata metadata = SettableMetadata(contentType: mimeType);

  UploadTask uploadTask =
      FirebaseStorage.instance.ref().child(ref).putFile(file, metadata);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}
