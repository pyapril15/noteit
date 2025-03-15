// lib/ui/screens/auth/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_circle_avatar.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_container.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_input_decoration.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_text_form_field.dart';
import 'package:noteit/ui/screens/auth/widgets/loading_button.dart';
import 'package:noteit/ui/widgets/gradient_background.dart';
import 'package:noteit/utils/constants.dart';

import '../../../app/routes.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            child: AuthContainer(
              child: Form(
                key: _authController.forgotPasswordFormKey,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthCircleAvatar(
                        child: AppConstants.appIcons.getForgotScreenIcon(),
                      ),
                      const SizedBox(height: 32),
                      AuthTextFormField(
                        controller: _emailController,
                        decoration: authInputDecoration(
                          prefixIcon: Icons.email,
                          hintText: 'Email ID',
                        ),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 20),
                      // Loading button
                      LoadingButton(
                        onPressed: () {
                          _authController.forgotPassword(_emailController.text);
                        },
                        label: 'RESET PASSWORD',
                        isLoading: _authController.isLoading.value,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          if (!_authController.isLoading.value) {
                            Get.offAllNamed(Routes.login);
                          }
                        },
                        child: const Text("Back to Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
