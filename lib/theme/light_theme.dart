import 'package:flutter/material.dart';

ThemeData light({Color? primaryColor, Color? secondaryColor}) => ThemeData(
      fontFamily: 'TitilliumWeb',
      primaryColor: primaryColor ?? const Color(0xFF04319e),
      brightness: Brightness.light,
      highlightColor: Colors.white,
      hintColor: const Color(0xFF9E9E9E),
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF04319e),
        secondary: const Color(0xFF04319e),
        tertiary: const Color(0xFFF9D4A8),
        tertiaryContainer: const Color(0xFFADC9F3),
        onTertiaryContainer: const Color(0xFF33AF74),
        onPrimary: const Color(0xFF7FBBFF),
        surface: const Color(0xFFF4F8FF),
        onSecondary: secondaryColor ?? const Color(0xFFF88030),
        error: const Color(0xFFFF5555),
        onSecondaryContainer: const Color(0xFFF3F9FF),
        outline: const Color(0xff2C66B4),
        onTertiary: const Color(0xFFE9F3FF),
        primaryContainer: const Color(0xFF9AECC6),
        secondaryContainer: const Color(0xFFF2F2F2),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
      }),
    );
