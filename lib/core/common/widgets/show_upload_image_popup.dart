//-- Open bottom popup for image upload
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/bloc/profile_setup_bloc.dart';

void showUploadImagePopup(context) {
  // final issueDetailBloc = BlocProvider.of<IssueDetailBloc>(context);
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 100),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: StatefulBuilder(
          builder: ((context, setState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 180.h,
                decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upload',
                            style: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 18.sp,
                              // color: kColorText,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Padding(
                              padding: EdgeInsets.all(5.h),
                              child: Icon(
                                Icons.close,
                                size: 18.h,
                                color: kColorSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h, bottom: 15.h),
                      child: Divider(color: kColorBlack.withOpacity(0.2)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              debugPrint("Image pick from gallery");
                              // issueDetailBloc.add(PickImageEvent());
                              context
                                  .read<ProfileSetupBloc>()
                                  .add(ProfileSetupPickImageEvent(true));
                            },
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    height: 40.h,
                                    width: 40.w,
                                    child: Icon(
                                      Icons.photo,
                                      size: 34.h,
                                    ),
                                  ),
                                  Center(
                                      child: Text(
                                    'Select From Gallery',
                                    textAlign: TextAlign.center,
                                    style:
                                        kTextStyleHelveticaRegular400.copyWith(
                                      fontSize: 12.sp,
                                      color: kColorSecondary,
                                    ),
                                  )),
                                ],
                              ),
                            )),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            debugPrint("Image pick from camera");
                            // issueDetailBloc.add(TakeImageEvent());
                            context
                                  .read<ProfileSetupBloc>()
                                  .add(ProfileSetupPickImageEvent(false));
                          },
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  height: 40.h,
                                  width: 40.w,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 34.h,
                                  ),
                                ),
                                Center(
                                  child: Text('Open Camera',
                                      style: kTextStyleHelveticaRegular400
                                          .copyWith(
                                        fontSize: 12.sp,
                                        color: kColorSecondary,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    },
  );
}
