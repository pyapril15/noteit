import 'package:get/get.dart';
import 'package:noteit/controllers/note_controller.dart';
import 'package:noteit/ui/screens/auth/forgot_password_screen.dart';

import '../controllers/auth_controller.dart';
import '../controllers/preferences_controller.dart';
import '../controllers/user_controller.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/signup_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/note_detail_screen.dart';
import '../ui/screens/profile_screen.dart';
import '../ui/screens/splash_screen.dart';

/// Class containing all the routes for the app.
class Routes {
  /// Initial route of the app.
  static const initialRoute = '/splash';

  /// Splash screen route.
  static const splash = '/splash';

  /// Login screen route.
  static const login = '/login';

  /// Signup screen route.
  static const signup = '/signup';

  /// Forgot password screen route.
  static const forgotPassword = '/forgot_password';

  /// Home screen route.
  static const home = '/home';

  /// Note detail screen route.
  static const note_detail = '/note_detail';

  /// Profile screen route.
  static const profile = '/profile';

  /// List of all pages in the app.
  static final pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      binding: SplashBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.cupertino,
      binding: AuthBinding(),
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      transition: Transition.cupertino,
      binding: AuthBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.cupertino,
      binding: AuthBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
      binding: GeneralBinding(),
    ),
    GetPage(
      name: note_detail,
      page: () => const NoteDetailScreen(),
      transition: Transition.cupertino,
      binding: GeneralBinding(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
      transition: Transition.cupertino,
      binding: ProfileBinding(),
    ),
  ];
}

/// Binding for the splash screen.
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

/// Binding for authentication screens.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

/// Binding for general screens.
class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => PreferencesController());
    Get.lazyPut(() => NoteController());
  }
}

/// Binding for the profile screen.
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => PreferencesController());
  }
}
