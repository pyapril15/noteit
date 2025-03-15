// lib/ui/screens/auth/splash_screen.dart
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteit/ui/widgets/loading_widget.dart';

import '../../app/routes.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../widgets/app_snackbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppConstants.appGradients.authGradient(),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppConstants.appIcons.getSplashScreenIcon(),
              const SizedBox(height: 20),
              Text(
                AppConstants.appStrings.splashScreenHeadline,
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: _authController.authStateChanges,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget(size: 30);
                  } else if (snapshot.hasError) {
                    developer.log(
                      'SplashScreen - Auth State Error',
                      error: snapshot.error,
                    );
                    Future.delayed(Duration.zero, () {
                      AppSnackbar.show(
                        'Error',
                        'An error occurred during authentication.',
                        isError: true,
                      );
                      Get.offAllNamed(Routes.login);
                    });
                    return const LoadingWidget(size: 30);
                  } else {
                    if (snapshot.hasData) {
                      Future.delayed(Duration.zero, () {
                        Get.offAllNamed(Routes.home);
                      });
                    } else {
                      Future.delayed(Duration.zero, () {
                        Get.offAllNamed(Routes.login);
                      });
                    }
                    return const LoadingWidget(size: 30);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
