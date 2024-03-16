import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_text.dart';
import '../../sign_up_page/sign_up_page.dart';

class LowerLine extends StatelessWidget {
  const LowerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          text: AppStrings.noAccount,
          isSamll: true,
        ),
        GestureDetector(
            onTap: () {
              Get.to(() => const SignUpPage());
            },
            child: const CustomText(
              text: AppStrings.createAccount,
              isSamll: true,
            )),
      ],
    );
  }
}
