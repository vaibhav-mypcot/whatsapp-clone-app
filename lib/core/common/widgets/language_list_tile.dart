import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
  });

  final int index;
  final int selectedIndex;
  final Function(int) onSelectedIndexChanged;

  static final List<Map<String, String>> languagesList = [
    {'English': "(device's language)"},
    {'हिंदी': 'Hindi'},
    {'मराठी': 'Marathi'},
    {'ગુજરાતી': 'Gujarati'},
    {'தமிழ்': 'Tamil'},
    {'తెలుగు': 'Telugu'},
    {'ಕನ್ನಡ': 'Kannada'},
    {'മലയാളം': 'Malayalam'},
    {'ਪੰਜਾਬੀ': 'Punjabi'},
    {'Español': 'Spanish'},
    {'中文': 'Chinese (Mandarin)'},
    {'العربية': 'Arabic'},
    {'Português': 'Portuguese'},
    {'Bengali': 'Bengali'},
    {'Pусский': 'Russian'},
    {'فارسی': 'Persian'},
    {'Deutsch': 'German'},
    {'日本語': 'Japanese'},
    {'한국어': 'Korean'},
    {'Français': 'French'},
    {'Italiano': 'Italian'},
    {'Türkçe': 'Turkish'},
    {'ไทย': 'Thai'},
    {'Tiếng Việt': 'Vietnamese'},
    {'Nederlands': 'Dutch'},
    {'Svenska': 'Swedish'}
  ];

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: index,
      groupValue: selectedIndex,
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return kColorPrimary;
        } else {
          return Colors.grey;
        }
      }),
      onChanged: (value) {
        onSelectedIndexChanged(index);
      },
      title: Text(
        languagesList[index].keys.first,
        style: kTextStyleHelveticaRegular400.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w200,
        ),
      ),
      subtitle: Text(
        languagesList[index].values.first,
        style: kTextStyleHelveticaRegular400.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w200,
          color: Colors.grey,
        ),
      ),
    );
    // return ListTile(
    //   leading: Radio(
    //     activeColor: kColorPrimary,
    //     value: index,
    //     fillColor: MaterialStateColor.resolveWith((states) {
    //       if (states.contains(MaterialState.selected)) {
    //         return kColorPrimary;
    //       } else {
    //         return Colors.grey;
    //       }
    //     }),
    //     groupValue: selectedIndex,
    //     onChanged: (value) {
    //       onSelectedIndexChanged(index);
    //     },
    //   ),
    //   title: Text(
    //     languagesList[index].keys.first,
    //     style: kTextStyleHelveticaRegular400.copyWith(
    //       fontSize: 14.sp,
    //       fontWeight: FontWeight.w200,
    //     ),
    //   ),
    //   subtitle: Text(
    //     languagesList[index].values.first,
    //     style: kTextStyleHelveticaRegular400.copyWith(
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w200,
    //       color: Colors.grey,
    //     ),
    //   ),
    // );
  }
}
