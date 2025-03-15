// lib/ui/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_circle_avatar.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_container.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_input_decoration.dart';
import 'package:noteit/ui/screens/auth/widgets/auth_text_form_field.dart';
import 'package:noteit/ui/screens/auth/widgets/loading_button.dart';
import 'package:noteit/utils/constants.dart';
import 'package:noteit/utils/validators.dart';

import '../../../app/routes.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/remember_me_controller.dart';
import '../../widgets/gradient_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final RememberMeController _rememberMeController = Get.put(
    RememberMeController(),
  );
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRememberMeData();
  }

  Future<void> _loadRememberMeData() async {
    await _rememberMeController.loadRememberMe();
    _emailController.text = _rememberMeController.rememberedEmail.value;
    _passwordController.text = _rememberMeController.rememberedPassword.value;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                key: _authController.loginFormKey,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AuthCircleAvatar(
                        child: AppConstants.appIcons.getLoginScreenIcon(),
                      ),
                      const SizedBox(height: 32.0),
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
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMeController.rememberMe.value,
                                onChanged: (value) {
                                  _rememberMeController.saveRememberMe(
                                    value!,
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                },
                              ),
                              Text("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.forgotPassword);
                            },
                            child: const Text("Forgot Password?"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      LoadingButton(
                        onPressed: () {
                          _authController.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                        label: 'LOGIN',
                        isLoading: _authController.isLoading.value,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          _authController.resendVerificationEmail();
                        },
                        child: const Text('Resend Verification Email'),
                      ),
                      TextButton(
                        onPressed: () => Get.offAllNamed(Routes.signup),
                        child: const Text('Don\'t have an account? Sign up'),
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
