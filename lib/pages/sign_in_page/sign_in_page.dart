import 'package:flutter/material.dart';
import '../../core/constants/assets_paths.dart';
import 'components/sign_in_body.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsPaths.background01),
                fit: BoxFit.cover)),
        child: SignInBody(),
      ),
    );
  }
}
