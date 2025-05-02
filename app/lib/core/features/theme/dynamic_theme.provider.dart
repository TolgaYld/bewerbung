import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/design/theme.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';

final dynamicThemeProvider = Provider<ThemeData>((ref) {
  final company = ref.watch(companyProvider).valueOrNull;

  return switch (company) {
    final company? => (company.primaryColor == null &&
            company.secondaryColor == null &&
            company.accentColor == null)
        ? AppTheme.lightTheme
        : _createCustomTheme(
            primaryColor: company.primaryColor,
            secondaryColor: company.secondaryColor,
            accentColor: company.accentColor,
          ),
    _ => AppTheme.lightTheme
  };
});

ThemeData _createCustomTheme({
  Color? primaryColor,
  Color? secondaryColor,
  Color? accentColor,
}) {
  final usedPrimaryColor = primaryColor ?? const Color(0xFF7D5F96);
  final usedSecondaryColor = secondaryColor ?? const Color(0xFF6C757D);
  final usedAccentColor = accentColor ?? const Color(0xFF5BC0EB);
  final onPrimaryColor = const Color(0xFFFFFFFF);

  final headingTextStyle = TextStyle(
    fontFamily: 'DMSans',
    color: usedPrimaryColor,
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );

  final bodyTextStyle = TextStyle(
    fontFamily: 'DMSans',
    color: usedPrimaryColor,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  final customTextTheme = TextTheme(
    displayLarge: headingTextStyle,
    bodyLarge: bodyTextStyle,
    bodyMedium: bodyTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: bodyTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: bodyTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w100,
    ),
    labelMedium: bodyTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w100,
    ),
    titleMedium: bodyTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: bodyTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: bodyTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );

  final customInputDecoration = InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: usedPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
      borderSide: BorderSide(color: usedPrimaryColor, width: 2),
    ),
    labelStyle: const TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
      borderSide: BorderSide(color: usedPrimaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacers.s),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    filled: true,
    fillColor: const Color(0xFFE2E8F0),
    prefixIconColor: const Color(0xFFFFFFFF),
    hintStyle: TextStyle(color: usedSecondaryColor),
  );

  final customElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: usedPrimaryColor,
      foregroundColor: onPrimaryColor,
      splashFactory: NoSplash.splashFactory,
      disabledBackgroundColor: usedPrimaryColor.withValues(alpha: 0.3),
      disabledForegroundColor: onPrimaryColor,
      minimumSize: const Size(240, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
    ),
  );

  final customIconTheme = IconThemeData(color: usedPrimaryColor);

  final customSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      return Colors.white;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? usedPrimaryColor
          : Colors.grey.shade400;
    }),
    trackOutlineColor: WidgetStatePropertyAll(usedPrimaryColor),
  );

  final customBottomNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFFFFFFFF),
    selectedItemColor: usedPrimaryColor,
    unselectedItemColor: Colors.grey[600],
    elevation: 8,
  );

  final customColorScheme = ColorScheme.light(
    surface: const Color(0xFFFFFFFF),
    primary: usedPrimaryColor,
    secondary: usedSecondaryColor,
    tertiary: usedAccentColor,
    outline: usedPrimaryColor,
    onPrimary: onPrimaryColor,
    onSecondary: usedPrimaryColor,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: customColorScheme,
    textTheme: customTextTheme,
    elevatedButtonTheme: customElevatedButtonTheme,
    inputDecorationTheme: customInputDecoration,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    iconTheme: customIconTheme,
    switchTheme: customSwitchTheme,
    bottomNavigationBarTheme: customBottomNavBarTheme,
    appBarTheme: AppBarTheme(
      toolbarHeight: 80,
      color: usedPrimaryColor,
      titleTextStyle: TextStyle(
        color: onPrimaryColor,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: onPrimaryColor),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[200],
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
    ),
  );
}
