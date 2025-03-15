import 'package:flutter/material.dart';

/// Color palette for the application.
class AppColors {
  static const Color primary = Color(0xFF64B5F6);
  static const Color primaryLight = Color(0xFF9BE7FF);
  static const Color primaryDark = Color(0xFF2196F3);
  static const Color accent = Color(0xFFFFC107);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF303030);
  static const Color cardLight = Colors.white;
  static final Color cardDark = Colors.grey[800]!;
  static const Color textLight = Color(0xFF212121);
  static const Color textDark = Color(0xFFE0E0E0);
  static const Color textSecondaryLight = Color(0xFF757575);
  static final Color textSecondaryDark = Colors.grey[400]!;
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static final Color greyLight = Colors.grey[100]!;
  static final Color greyDark = Colors.grey[900]!;
}

// Text Theme
class AppTextStyles {
  static TextTheme textTheme(bool isDarkMode) {
    Color textColor = isDarkMode ? AppColors.textDark : AppColors.textLight;
    Color secondaryTextColor =
        isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: secondaryTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.white54,
      ),
    );
  }
}

// Input Decoration Theme
class AppInputDecorations {
  static InputDecorationTheme inputDecorationTheme(bool isDarkMode) {
    Color fillColor =
        isDarkMode ? AppColors.greyDark.withAlpha(128) : AppColors.greyLight;
    Color borderColor =
        isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    Color textColor = isDarkMode ? AppColors.textDark : AppColors.textLight;

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: TextStyle(
        color: borderColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: TextStyle(color: borderColor.withAlpha(128), fontSize: 14.0),
      errorStyle: TextStyle(color: AppColors.error, fontSize: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppColors.error, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderColor.withAlpha(128), width: 1.5),
      ),
      prefixIconColor: textColor,
      suffixIconColor: textColor,
      iconColor: AppColors.primary,
      alignLabelWithHint: true,
    );
  }
}

// Button Themes
class AppButtons {
  static ElevatedButtonThemeData elevatedButtonThemeData(bool isDarkMode) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryLight;
          }
          if (states.contains(WidgetState.disabled)) return Colors.grey[400];
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(2),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  static TextButtonThemeData textButtonThemeData(bool isDarkMode) {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryLight;
          }
          if (states.contains(WidgetState.disabled)) return Colors.grey;
          return AppColors.primary;
        }),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

// Progress Indicator Theme
class AppProgressIndicators {
  static ProgressIndicatorThemeData progressIndicatorThemeData(
    bool isDarkMode,
  ) {
    return ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
      circularTrackColor: isDarkMode ? Colors.grey[600] : Colors.grey[200],
      refreshBackgroundColor:
          isDarkMode ? AppColors.greyDark : AppColors.backgroundLight,
    );
  }
}

// Checkbox Theme
class AppCheckboxes {
  static CheckboxThemeData checkboxThemeData(bool isDarkMode) {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: Colors.transparent, width: 2),
      checkColor: WidgetStateProperty.all(AppColors.success),
      fillColor: WidgetStateProperty.all(
        isDarkMode ? Colors.white70 : Colors.white70,
      ),
      overlayColor: WidgetStateProperty.all(AppColors.success.withAlpha(77)),
      splashRadius: 20,
    );
  }
}

// App Theme
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    hintColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,
    listTileTheme: ListTileThemeData(tileColor: AppColors.cardLight),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.textLight,
      elevation: 0,
    ),
    textTheme: AppTextStyles.textTheme(false),
    inputDecorationTheme: AppInputDecorations.inputDecorationTheme(false),
    elevatedButtonTheme: AppButtons.elevatedButtonThemeData(false),
    textButtonTheme: AppButtons.textButtonThemeData(false),
    progressIndicatorTheme: AppProgressIndicators.progressIndicatorThemeData(
      false,
    ),
    checkboxTheme: AppCheckboxes.checkboxThemeData(false),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.cardLight,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.textLight,
      onError: Colors.white,
    ).copyWith(surface: AppColors.backgroundLight),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    hintColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,
    listTileTheme: ListTileThemeData(tileColor: AppColors.cardDark),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade800,
      foregroundColor: AppColors.textDark,
      elevation: 0,
    ),
    textTheme: AppTextStyles.textTheme(true),
    inputDecorationTheme: AppInputDecorations.inputDecorationTheme(true),
    elevatedButtonTheme: AppButtons.elevatedButtonThemeData(true),
    textButtonTheme: AppButtons.textButtonThemeData(true),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
    ),
    progressIndicatorTheme: AppProgressIndicators.progressIndicatorThemeData(
      true,
    ),
    checkboxTheme: AppCheckboxes.checkboxThemeData(true),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.cardDark,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.textDark,
      onError: Colors.white,
    ).copyWith(surface: AppColors.backgroundDark),
  );
}
