import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/common/widgets/customButton.dart';
import 'package:whatsapp_clone_app/core/common/widgets/customTextField.dart';
import 'package:whatsapp_clone_app/core/common/widgets/loader_widget.dart';
import 'package:whatsapp_clone_app/core/common/widgets/show_snackbar_widget.dart';
import 'package:whatsapp_clone_app/core/common/widgets/show_upload_image_popup.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/core/utils/validation_mixin.dart';
import 'package:whatsapp_clone_app/feature/dashboard/dashboard_screen/presentation/page/dashboard_screen.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/bloc/profile_setup_bloc.dart';

class SetupProfileScreen extends StatelessWidget with ValidationMixin {
  SetupProfileScreen({super.key});

  static const String route = '/setup_profile_screen';

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController statusTextController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  //-- Submit Details
  void _onSubmitDetails({
    required BuildContext context,
    required String username,
    required String status,
  }) {
    print("${username.toString()} \n${status.toString()}");
    if (registerFormKey.currentState!.validate()) {
      context.read<ProfileSetupBloc>().add(
            ProfileSetupCreateUserAcEvent(
              userName: username,
              staus: status,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileSetupBloc, ProfileSetupState>(
              listener: (ctx, state) {
            if (state is ProfileSetupSuccessState) {
              Navigator.pushReplacementNamed(context, DashboardScreen.route);
            } else if (state is ProfileSetupErrorState) {
              debugPrint("Got issue in update profile");
              showSnackBar(context, state.errorMessage);
            }
          })
        ],
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Form(
                            key: registerFormKey,
                            child: Column(
                              children: [
                                // Herader
                                AppBar(
                                  automaticallyImplyLeading: false,
                                  centerTitle: true,
                                  title: Text(
                                    'Profile setup',
                                    style: kTextStyleHelveticaLight300.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode
                                          ? kColorWhite
                                          : kColorPineGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 36.h),
                                SizedBox(
                                  height: 115,
                                  width: 115,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      BlocBuilder<ProfileSetupBloc,
                                          ProfileSetupState>(
                                        builder: (context, state) {
                                          if (state
                                              is ProfileSetupPickedImageState) {
                                            return CircleAvatar(
                                                foregroundImage: FileImage(
                                                    File(state.image.path)));
                                          }
                                          return const CircleAvatar(
                                            foregroundImage: AssetImage(
                                                    Constants.profileImage)
                                                as ImageProvider,
                                          );
                                        },
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: -25,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            showUploadImagePopup(context);
                                          },
                                          elevation: 2.0,
                                          fillColor: const Color(0xFFF5F6F9),
                                          padding: const EdgeInsets.all(8.0),
                                          shape: const CircleBorder(),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: kColorPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 34.h),

                                // Username fields
                                SizedBox(height: 12.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 6.h),
                                            CustomTextfieldWidget(
                                              controller:
                                                  usernameTextController,
                                              hintText: 'Username',
                                              hintStyle:
                                                  kTextStyleHelveticaRegular400
                                                      .copyWith(
                                                fontSize: 14.sp,
                                                // color: kColorGreyNeutral400,
                                              ),
                                              radius: 8,
                                              style:
                                                  kTextStyleHelveticaRegular400
                                                      .copyWith(
                                                fontSize: 14.sp,
                                                // color: kColorGreyNeutral600,
                                              ),
                                              textInputType: TextInputType.name,
                                              validator: validatedName,
                                            ),
                                            SizedBox(height: 16.h),
                                            CustomTextfieldWidget(
                                              controller: statusTextController,
                                              hintText: 'Status',
                                              hintStyle:
                                                  kTextStyleHelveticaRegular400
                                                      .copyWith(
                                                fontSize: 14.sp,
                                                // color: kColorGreyNeutral400,
                                              ),
                                              radius: 8,
                                              style:
                                                  kTextStyleHelveticaRegular400
                                                      .copyWith(
                                                fontSize: 14.sp,
                                                // color: kColorGreyNeutral600,
                                              ),
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              validator: validatedStatus,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 34.h),
                                // Email & Phone Number
                                // Submit Button
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 16.w,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: CustomButton(
                                    isDarkMode: isDarkMode,
                                    label: "Create Account",
                                    onTap: () => _onSubmitDetails(
                                      context: context,
                                      username: usernameTextController.text,
                                      status: statusTextController.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
                builder: (context, state) {
                  if (state is ProfileSetupLoadingState) {
                    return const LoaderWidget();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
