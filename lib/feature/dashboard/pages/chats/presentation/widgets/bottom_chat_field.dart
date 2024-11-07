import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_app/core/common/enum/message_enum.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/bloc/chat_bloc.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    super.key,
    required this.isDarkMode,
    required this.reciverUserId,
  });

  final bool isDarkMode;
  final String reciverUserId;

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final messageTextController = TextEditingController();
  bool isShowEmojiContainer = false;
  bool isHideIcons = false;
  bool isPressed = false;
  FocusNode focusNode = FocusNode();
  bool isRecorderInit = false;
  bool isRecording = false;
  FlutterSoundRecorder? _soundRecorder;
  var path;

  @override
  void initState() {
    super.initState();

    _soundRecorder = FlutterSoundRecorder();
    openAudio();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true); // Loop back and forth

    // Define a Tween to animate the vertical position from 0 to 10 pixels
    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void openAudio() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed');
    }

    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose the controller to free resources
    _soundRecorder?.closeRecorder(); // Close the audio recorder
    isRecorderInit = false; //
  }

  void _toggleButtonSize(bool pressed) async {
    setState(() {
      isPressed = !isPressed;
    });
    await _soundRecorder!.stopRecorder();
  }

  void recordSound() async {
    print("Sound recording start");
    var tempDir = await getTemporaryDirectory();
    path = '${tempDir.path}/flutter_sound.aac';
    await _soundRecorder!.startRecorder(
      toFile: path,
    );
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      hideEmojiContainer();
      Future.delayed(const Duration(milliseconds: 100), showKeyboard);
    } else {
      hideKeyboard();
      Future.delayed(const Duration(milliseconds: 100), showEmojiContainer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.amberAccent,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 4.h),
                      decoration: BoxDecoration(
                          color: widget.isDarkMode
                              ? const Color(0xFF1F2C34)
                              : kColorWhite,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.only(top: 2.h),
                      child: FocusScope(
                        canRequestFocus: !isShowEmojiContainer,
                        child: TextFormField(
                          focusNode: focusNode,
                          maxLines: null,
                          controller: messageTextController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 8.h),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8.w),
                                //-- Open emoji keyboard
                                GestureDetector(
                                  onTap: () => toggleEmojiKeyboardContainer(),
                                  child: SvgPicture.asset(
                                    isShowEmojiContainer
                                        ? Constants.keyboardIc
                                        : Constants.smileIc,
                                    fit: BoxFit.cover,
                                    height: 24.h,
                                  ),
                                )
                              ],
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => context
                                      .read<ChatBloc>()
                                      .add(SendVideoEvent(
                                        msgEnum: MessageEnum.video,
                                        reciverUserId: widget.reciverUserId,
                                      )),
                                  child: SvgPicture.asset(
                                    Constants.attachFileIc,
                                    fit: BoxFit.cover,
                                    height: 24.h,
                                  ),
                                ),
                                SizedBox(width: 14.w),
                                // chatScreenController.isTextEntered.value
                                //     ? SizedBox.shrink()
                                //     :
                                (isHideIcons || !isPressed)
                                    ? const SizedBox.shrink()
                                    : Row(
                                        children: [
                                          SvgPicture.asset(
                                            Constants.paymentIc,
                                            fit: BoxFit.cover,
                                            height: 20.h,
                                          ),
                                          SizedBox(width: 14.w),
                                          InkWell(
                                            onTap: () => context
                                                .read<ChatBloc>()
                                                .add(SendImageMessageEvent(
                                                  msgEnum: MessageEnum.image,
                                                  reciverUserId:
                                                      widget.reciverUserId,
                                                )),
                                            child: SvgPicture.asset(
                                              Constants.cameraIc,
                                              fit: BoxFit.cover,
                                              height: 24.h,
                                            ),
                                          ),
                                          SizedBox(width: 14.w),
                                        ],
                                      ),
                              ],
                            ),
                            hintText: "Message",
                            hintStyle: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: kTextStyleHelveticaRegular400.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          enableSuggestions: false,
                          cursorColor: kColorPrimary,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                isHideIcons = true;
                              });
                            } else {
                              setState(() {
                                isHideIcons = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 45.w,
                  ),
                ],
              ),
              // Send message button
              isPressed
                  ? Container(
                      height: 140.h,
                      width: 50.w,
                      margin: EdgeInsets.fromLTRB(0.w, 0.h, 14.w, 12.h),
                      decoration: BoxDecoration(
                        color: kColorDarkGray,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h),
                          Icon(
                            Icons.lock_outline,
                            size: 18.h,
                          ),
                          SizedBox(height: 12.h),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: _animation
                                        .value), // Apply vertical offset
                                child: const Icon(
                                  Icons
                                      .keyboard_arrow_up_rounded, // Up arrow icon
                                  size: 18,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              GestureDetector(
                // onLongPress: () {
                //   if (!isHideIcons) {
                //     _toggleButtonSize(true);
                //   }
                // },
                onTapDown: (_) {
                  if (!isHideIcons) {
                    _toggleButtonSize(true); // Button grows when pressed
                    recordSound();
                  }
                },
                onTapUp: (_) {
                  _toggleButtonSize(
                      false); // Button returns to normal size when finger is lifted
                  context.read<ChatBloc>().add(
                        SendAudioEvent(
                          reciverUserId: widget.reciverUserId,
                          msgEnum: MessageEnum.audio,
                          file: File(path),
                        ),
                      );
                },

                onTapCancel: () => _toggleButtonSize(false),

                // onTap: () {
                //   if (!isHideIcons) {
                //     _toggleButtonSize();
                //   } else {
                //     if (messageTextController.text.isNotEmpty) {
                //       context.read<ChatBloc>().add(SendTextMessageEvent(
                //             message: messageTextController.text,
                //             reciverUserId: widget.reciverUserId,
                //           ));
                //     }
                //   }
                //   messageTextController.clear();
                // },
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: isPressed ? 68.w : 42.h, // Change width when pressed
                    height: isPressed ? 68.h : 42.h,
                    margin: EdgeInsets.fromLTRB(0, 0, 8.w, 6.h),
                    decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(
                      isHideIcons ? Icons.send : Icons.mic,
                      color: kColorWhite,
                    )

                    // child: chatScreenController.isTextEntered.value
                    //     ? const Icon(
                    //         Icons.send,
                    //         color: kColorWhite,
                    //       )
                    //     : const Icon(
                    //         Icons.mic,
                    //         color: kColorWhite,
                    //       ),
                    ),
              ),
            ],
          ),
        ),
        //---
        isShowEmojiContainer
            ? SizedBox(
                height: 310.h,
                child: EmojiPicker(
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      messageTextController.text =
                          messageTextController.text + emoji.emoji;
                    });
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
