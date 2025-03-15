// lib/ui/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_circle_avatar.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_container.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_input_decoration.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_text_form_field.dart';
import 'package:noteit/ui/screens/auth/widgets/loading_button.dart';
import 'package:noteit/utils/validators.dart';

import '../../../app/routes.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../widgets/gradient_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
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
                key: _authController.signupFormKey,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AuthCircleAvatar(
                        child: AppConstants.appIcons.getSignupScreenIcon(),
                      ),
                      const SizedBox(height: 32),
                      AuthTextFormField(
                        controller: _nameController,
                        decoration: authInputDecoration(
                          prefixIcon: Icons.person,
                          hintText: 'Name',
                        ),
                        validator: validateCharactersOnly,
                      ),
                      const SizedBox(height: 20.0),
                      AuthTextFormField(
                        controller: _emailController,
                        decoration: authInputDecoration(
                          prefixIcon: Icons.email,
                          hintText: 'Email ID',
                        ),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 20.0),
                      AuthTextFormField(
                        controller: _passwordController,
                        decoration: authInputDecoration(
                          prefixIcon: Icons.lock,
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 20.0),
                      AuthTextFormField(
                        controller: _confirmPasswordController,
                        decoration: authInputDecoration(
                          prefixIcon: Icons.lock,
                          hintText: 'Confirm Password',
                        ),
                        obscureText: true,
                        validator:
                            (value) => validateConfirmPassword(
                              value,
                              _passwordController,
                            ),
                      ),
                      const SizedBox(height: 20.0),
                      LoadingButton(
                        onPressed: () {
                          _authController.signup(
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                        label: 'SIGNUP',
                        isLoading: _authController.isLoading.value,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Get.offAllNamed(Routes.login),
                        child: const Text('Already have an account? Login'),
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
