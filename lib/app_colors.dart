import 'package:flutter/material.dart';

/// All the colors used in the application are defined here
/// Update the colors as desired with their dark mode variations below them.

abstract class AppColors {
  /// **************    Gradients   *******************
  static LinearGradient backgroundGradient = const LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    stops: [
      0.0,
      0.6,
      1.0,
    ],
    colors: <Color>[
      Color(0xFF000741),
      Color.fromARGB(129, 0, 7, 65),
      Color(0xFFBEC2E4),
    ],
  );
  

  static const dark = Color.fromARGB(255, 0, 0, 0);

  static const light = Color(0xFFFAFAFA);

  static const Color primary = Color(0XFF1E134E);
  static const Color primaryDark = Color(0XFF327dcd);

  static const Color secondary = Color(0xFFAFB762);
  static const Color secondaryDark = Color(0xFFcd8232);

  static const Color accent = Color(0xFF24AAF0);
  static const Color accentDark = Color(0xFF88F4A0);

  static const Color buttonColor = Color(0XFF08651C);

  static const Color textColors = Color.fromARGB(255, 27, 27, 27);

  /// Primary text color
  static const primaryText = Colors.white;

  static Color buttonBackgroundColor =
      const Color.fromARGB(255, 66, 50, 205).withAlpha(80);

  static const Color cardColor = Color(0xFF50489E);
  static const Color successColor = Color(0xCC4CAF50);

  // Disabled Color
  static const Color mDisabledColor = Color.fromARGB(175, 162, 162, 162);

  static const Color lightShadowColor = Color.fromARGB(224, 226, 226, 226);
  static const faded = Color.fromARGB(255, 59, 80, 106);
  static const Color mWhite = Color(0xFFF4F5FA);
  static const Color errorText = Color.fromARGB(255, 255, 4, 0);
  static const Color lightGrey = Color(0xFFA8A8A8);
  static const Color lightWhite = Color.fromARGB(53, 168, 168, 168);
  static const grey = Color(0xFF262626);
  static const Color backgroundDark = Color.fromRGBO(42, 42, 42, 1);
  static const Color backgroundLight = Color(0XFFE5E5E5);
  static const Color transparentColor = Colors.transparent;

  // General Colors
  static const Color lightPurpleColor = Color(0xFFEFC0F7);

  // General Colors

  // White
  static const Color white1 = Color.fromRGBO(255, 255, 255, 0.01);
  static const Color white3 = Color.fromRGBO(255, 255, 255, 0.03);
  static const Color white5 = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color white10 = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color white15 = Color.fromRGBO(255, 255, 255, 0.15);
  static const Color white20 = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color white25 = Color.fromRGBO(255, 255, 255, 0.226);
  static const Color white30 = Color.fromRGBO(255, 255, 255, 0.3);
  static const Color white40 = Color.fromRGBO(255, 255, 255, 0.4);
  static const Color white50 = Color.fromRGBO(255, 255, 255, 0.5);
  static const Color white60 = Color.fromRGBO(255, 255, 255, 0.6);
  static const Color white70 = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color white80 = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color white90 = Color.fromRGBO(255, 255, 255, 0.9);
  static const Color white100 = Color.fromRGBO(255, 255, 255, 1);

  // Gray
  static const Color gray50 = Color(0XFFF8FAFC);
  static const Color gray100 = Color(0XFFF3F4F6);
  static const Color gray200 = Color(0XFFE5E7EB);
  static const Color gray300 = Color(0XFFD1D5DB);
  static const Color gray400 = Color(0XFF9CA3AF);
  static const Color gray = Color(0XFF6B7280);
  static const Color gray600 = Color(0XFF4B5563);
  static const Color gray700 = Color(0XFF374151);
  static const Color gray800 = Color(0XFF1F2937);
  static const Color gray900 = Color(0XFF111827);

  // Green
  static const Color green50 = Color(0XFFF0FDF4);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green200 = Color(0XFFBBF7D0);
  static const Color green300 = Color(0XFF86EFAC);
  static const Color green400 = Color(0XFF4ADE80);
  static const Color green = Color(0XFF22C55E);
  static const Color green600 = Color(0XFF16A34A);
  static const Color green700 = Color(0XFF15803D);
  static const Color green800 = Color(0XFF166534);
  static const Color green900 = Color(0XFF14532D);

  // Teal
  static const Color teal50 = Color(0XFFF0FDFA);
  static const Color teal100 = Color(0xFFCCFBF1);
  static const Color teal200 = Color(0XFF99F6E4);
  static const Color teal300 = Color(0XFF5EEAD4);
  static const Color teal400 = Color(0XFF2DD4BF);
  static const Color teal = Color(0XFF14B8A6);
  static const Color teal600 = Color(0XFF0D9488);
  static const Color teal700 = Color(0XFF0F766E);
  static const Color teal800 = Color(0XFF115E59);
  static const Color teal900 = Color(0XFF134E4A);

  // Blue
  static const Color blue50 = Color(0XFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0XFFBFDBFE);
  static const Color blue300 = Color(0XFF93C5FD);
  static const Color blue400 = Color(0XFF60A5FA);
  static const Color blue = Color(0XFF3B82F6);
  static const Color blue600 = Color(0XFF2563EB);
  static const Color blue700 = Color(0XFF1D4ED8);
  static const Color blue800 = Color(0XFF1E40AF);
  static const Color blue900 = Color(0XFF1E3A8A);

  // Purple
  static const Color purple50 = Color(0XFFFAF5FF);
  static const Color purple100 = Color(0xFFF3E8FF);
  static const Color purple200 = Color(0XFFE9D5FF);
  static const Color purple300 = Color(0XFFD8B4FE);
  static const Color purple400 = Color(0XFFC084FC);
  static const Color purple = Color(0XFFA855F7);
  static const Color purple600 = Color(0XFF9333EA);
  static const Color purple700 = Color(0XFF7E22CE);
  static const Color purple800 = Color(0XFF6B21A8);
  static const Color purple900 = Color(0XFF581C87);

  // Red
  static const Color red50 = Color(0XFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red200 = Color(0XFFFECACA);
  static const Color red300 = Color(0XFFFCA5A5);
  static const Color red400 = Color(0XFFF87171);
  static const Color red = Color(0XFFEF4444);
  static const Color red600 = Color(0XFFDC2626);
  static const Color red700 = Color(0XFFB91C1C);
  static const Color red800 = Color(0XFF991B1B);
  static const Color red900 = Color(0XFF7F1D1D);

  // Orange
  static const Color orange50 = Color(0XFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange200 = Color(0XFFFED7AA);
  static const Color orange300 = Color(0XFFFDBA74);
  static const Color orange400 = Color(0XFFFB923C);
  static const Color orange = Color(0XFFF97316);
  static const Color orange600 = Color(0XFFEA580C);
  static const Color orange700 = Color(0XFFC2410C);
  static const Color orange800 = Color(0XFF9A3412);
  static const Color orange900 = Color(0XFF7C2D12);

  // Yellow
  static const Color yellow50 = Color(0XFFFEFCE8);
  static const Color yellow100 = Color(0xFFFEF9C3);
  static const Color yellow200 = Color(0XFFFEF08A);
  static const Color yellow300 = Color(0XFFFDE047);
  static const Color yellow400 = Color(0XFFFACC15);
  static const Color yellow = Color(0XFFEAB308);
  static const Color yellow600 = Color(0XFFCA8A04);
  static const Color yellow700 = Color(0XFFA16207);
  static const Color yellow800 = Color(0XFF854D0E);
  static const Color yellow900 = Color(0XFF713F12);
}