import 'package:flutter/material.dart';
import '../../core/constants/assets_paths.dart';
import 'components/sign_up_body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsPaths.background01),
                fit: BoxFit.cover)),
        child: SignUpBody(),
      ),
    );
  }
}
