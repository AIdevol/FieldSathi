import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MontserratStyles {
  static montserratThinTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
  }) {
    return GoogleFonts.montserrat(
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w100,
      color: color,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static montserratNormalTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.black,
    FontWeight weight = FontWeight.w400,
    bool underLineNeeded = false,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.montserrat(
        fontSize: size,
        height: height,
        fontWeight: weight,
        color: color,
        decoration:
        underLineNeeded ? TextDecoration.underline : TextDecoration.none,
        shadows: shadows
    );
  }

  static montserratMediumTextStyle({
    double size = 15,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
  }) {
    return GoogleFonts.montserrat(
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w500,
      color: color,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static montserratRegularTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
    bool italicFontStyle = false,
  }) {
    return GoogleFonts.montserrat(
      fontStyle: italicFontStyle ? FontStyle.italic : FontStyle.normal,
      fontSize: size,
      fontWeight: FontWeight.w300,
      height: height,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
      color: color,
    );
  }

  static montserratSemiBoldTextStyle({
    double size = 15,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
  }) {
    return GoogleFonts.montserrat(
      fontSize: size,
      height: height,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static montserratBoldTextStyle({
    double size = 14,
    double height = 1.2,
    double letterSpacing = 1,
    Color color = Colors.white,
    bool underLineNeeded = false,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.montserrat(
        fontSize: size,
        height: height,
        decoration:
        underLineNeeded ? TextDecoration.underline : TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: letterSpacing,
        shadows: shadows);
  }

  static TextStyle? commonTextStyle(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }
}

class LatoStyles {
  static latothinTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w100,
      color: color,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static latonormalTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
    FontWeight weight = FontWeight.w400,
    double letterSpacing = -0.3,
    shadows,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      height: height,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      shadows: shadows ?? [],
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static latomediumTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w500,
      color: color,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static latoregularTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
    bool italicFontStyle = false,
  }) {
    return GoogleFonts.lato(
      fontStyle: italicFontStyle ? FontStyle.italic : FontStyle.normal,
      fontSize: size,

      fontWeight: FontWeight.w300,
      height: height,
      // overflow: TextOverflow.ellipsis,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
      color: color,
    );
  }

  static latosemiBoldTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.white,
    bool underLineNeeded = false,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      height: height,
      decoration:
      underLineNeeded ? TextDecoration.underline : TextDecoration.none,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static latoboldTextStyle({
    double size = 14,
    double height = 1.2,
    Color color = Colors.black,
    bool underLineNeeded = false,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.lato(
        fontSize: size,
        height: height,
        decoration:
        underLineNeeded ? TextDecoration.underline : TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: color,
        shadows: shadows);
  }

  static TextStyle? commonTextStyle(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }
}
