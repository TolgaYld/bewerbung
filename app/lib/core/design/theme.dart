import 'package:flutter/material.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';

class AppTheme {
  AppTheme._();

  // Light Theme Colors
  static const Color _lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color _lightGreyBackgroundColor = Color(0xFFE2E8F0);
  static const Color _lightPrimaryColor = Color(0xFF7D5F96);
  static const Color _lightSecondaryColor = Color(0xFF6C757D);
  static const Color _lightOnPrimaryColor = Color(0xFFFFFFFF);
  static const Color _lightTextColorPrimary = _lightPrimaryColor;
  static const Color _appBarColorLight = _lightPrimaryColor;

  // Dark Theme Colors
  static final Color _darkBackgroundColor = Colors.grey[850] ?? Colors.black;
  static final Color _darkPrimaryColor = Colors.grey[850] ?? Colors.black;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkOnPrimaryColor = Color(0xFFFFD700);
  static const Color _darkTextColorPrimary = Color(0xFFFFD700);
  static final Color _appBarColorDark = Colors.grey[850] ?? Colors.black;

  // Tertiary Colors
  static const Color _tertiaryColor = Color(0xFF5BC0EB);

  static final TextStyle _lightHeadingText = TextStyle(
    fontFamily: 'DMSans',
    color: _lightTextColorPrimary,
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle _lightBodyText = TextStyle(
    fontFamily: 'DMSans',
    color: _lightTextColorPrimary,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
    bodyMedium: _lightBodyText.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: _lightBodyText.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: _lightBodyText.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w100,
    ),
    labelMedium: _lightBodyText.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w100,
    ),
    titleMedium: _lightBodyText.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: _lightBodyText.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: _lightBodyText.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _lightHeadingText.copyWith(color: _darkTextColorPrimary),
    bodyLarge: _lightBodyText.copyWith(color: _darkTextColorPrimary),
  );

  static final _lightCardTheme = CardTheme(
    color: Colors.grey[200],
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
    ),
  );

  static final _surface = _lightBackgroundColor;

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: _lightTextColorPrimary),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
      borderSide: const BorderSide(color: _lightTextColorPrimary, width: 2),
    ),
    labelStyle: const TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
      borderSide: const BorderSide(color: _lightPrimaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    filled: true,
    fillColor: _lightGreyBackgroundColor,
    prefixIconColor: _surface,
    hintStyle: const TextStyle(color: _lightSecondaryColor),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: _lightOnPrimaryColor,
      splashFactory: NoSplash.splashFactory,
      disabledBackgroundColor: _lightPrimaryColor.withValues(alpha: 0.3),
      disabledForegroundColor: _lightOnPrimaryColor,
      minimumSize: const Size(Spacers.x5l, (Spacers.x2l + Spacers.s)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
    ),
  );

  static final _iconTheme = IconThemeData(color: _lightPrimaryColor);
  static final _darkIconTheme = IconThemeData(color: _darkPrimaryColor);

  static final _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: _lightBackgroundColor,
    selectedItemColor: _lightPrimaryColor,
    unselectedItemColor: Colors.grey[600],
    elevation: 8,
  );

  static final _darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: _darkBackgroundColor,
    selectedItemColor: _darkOnPrimaryColor,
    unselectedItemColor: Colors.grey[400],
    elevation: 8,
  );

  static final _switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      return Colors.white;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? _lightPrimaryColor
          : Colors.grey.shade400;
    }),
    trackOutlineColor: WidgetStatePropertyAll(_lightPrimaryColor),
  );

  static final ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: _elevatedButtonTheme,
    useMaterial3: true,
    inputDecorationTheme: _inputDecorationTheme,
    scaffoldBackgroundColor: _lightBackgroundColor,
    cardTheme: _lightCardTheme,
    iconTheme: _iconTheme,
    switchTheme: _switchTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    appBarTheme: const AppBarTheme(
      toolbarHeight: 80,
      color: _appBarColorLight,
      titleTextStyle: TextStyle(
        color: _lightOnPrimaryColor,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      surface: _surface,
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      tertiary: _tertiaryColor,
      outline: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: _lightTextColorPrimary,
    ),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: AppBarTheme(
      color: _appBarColorDark,
      titleTextStyle: TextStyle(
        fontSize: 18,
      ),
    ),
    iconTheme: _darkIconTheme,
    bottomNavigationBarTheme: _darkBottomNavigationBarTheme,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      tertiary: _tertiaryColor,
      primaryContainer: _darkPrimaryVariantColor,
    ),
    textTheme: _darkTextTheme,
  );
}
