import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/common/widgets/customButton.dart';
import 'package:whatsapp_clone_app/core/common/widgets/customTextField.dart';
import 'package:whatsapp_clone_app/core/common/widgets/show_snackbar_widget.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/widget/popupmenu_button_widget.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  static const String route = '/phone_number_screen';

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController(text: "91");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PhoneNumberBloc>().add(PhoneNumbersFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Enter your phone number',
          style: kTextStyleHelveticaLight300.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? kColorWhite : kColorPineGreen,
          ),
        ),
        actions: [
          PopupmenuButtonWidget(
            isDarkMode: isDarkMode,
          ),
        ],
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PhoneNumberBloc, PhoneNumberState>(
              listener: (context, state) {
            if (state is PhoneNumberFailureState) {
              showSnackBar(context, state.error);
            }
          }),
        ],
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "WhatsApp will need to verify your account. ",
                      style: kTextStyleHelveticaRegular400.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w200,
                      ),
                      children: const [
                        TextSpan(
                          text: "What's my number?",
                          style: TextStyle(
                              color:
                                  Colors.blue), // Change the color of this text
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    // onTap: () => Get.toNamed(AppRoutes.countryCodeScreen),
                    child: Container(
                      width: 240.w,
                      height: 26.h,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: kColorPrimary,
                            width: 0.6,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'India',
                              textAlign: TextAlign.center,
                              style: kTextStyleHelveticaRegular400.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: kColorPrimary,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 240.w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 52.w,
                          child: CustomTextfieldWidget(
                            // initialValue: "91",
                            controller: countryCodeController,
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2)
                            ],
                            textAlignVertical: TextAlignVertical.bottom,
                            prefixIcon: Container(
                              width: 24.w,
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.add,
                                size: 14.h,
                                color: Colors.grey,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 0,
                            ),
                            hintStyle: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            style: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomTextfieldWidget(
                            textInputType: TextInputType.number,
                            controller: phoneNumberController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            hintText: "phone number",
                            hintStyle: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            style: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    'International carrier charges may apply',
                    textAlign: TextAlign.center,
                    style: kTextStyleHelveticaRegular400.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 60.w,
                      padding: EdgeInsets.only(bottom: 20.h),
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          // Navigator.pushNamed(context, VerifyNumberScreen.route);
                          print(
                              "phone number: +${countryCodeController.text.toString()}${phoneNumberController.text.toString()}");
                          context
                              .read<PhoneNumberBloc>()
                              .add(PhoneNumberVerificationEvent(
                                "+${countryCodeController.text.toString()}${phoneNumberController.text.toString()}",
                                context,
                              ));
                        },
                        child: CustomButton(
                          label: "Next",
                          isDarkMode: isDarkMode,
                          radius: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
                builder: (ctx, state) {
              if (state is PhoneNumberLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
