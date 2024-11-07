// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SendTextMessageEvent extends ChatEvent {
  final String message;
  final String reciverUserId;

  SendTextMessageEvent({
    required this.message,
    required this.reciverUserId,
  });
}

class SendImageMessageEvent extends ChatEvent {
  final String reciverUserId;
  final MessageEnum msgEnum;

  SendImageMessageEvent({
    required this.reciverUserId,
    required this.msgEnum,
  });
}

class SendVideoEvent extends ChatEvent {
  final String reciverUserId;
  final MessageEnum msgEnum;

  SendVideoEvent({
    required this.reciverUserId,
    required this.msgEnum,
  });
}

class SendAudioEvent extends ChatEvent {
  final String reciverUserId;
  final MessageEnum msgEnum;
  final File file;

  SendAudioEvent({
    required this.reciverUserId,
    required this.msgEnum,
    required this.file,
  });
}
