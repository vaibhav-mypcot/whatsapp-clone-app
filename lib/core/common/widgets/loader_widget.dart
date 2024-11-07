import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator(
          value: 0.5,
          color: kColorPineGreen,
          strokeWidth: 5.0,
        ),
      ),
    );
  }
}