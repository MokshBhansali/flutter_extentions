import 'package:flt_extentions/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors.dart';

class AppTheme {
  static TextStyle get headline5 => myFontStyle(
      fontSize: AppFontSize.headLine5.sp, fontWeight: FontWeight.w500);
  static TextStyle get headline6 => myFontStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppFontSize.headLine6.toSp as double,
        letterSpacing: 0.15,
      );
  static TextStyle get headline4 => myFontStyle(
        fontSize: AppFontSize.headLine4.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
  static TextStyle get headline3 => myFontStyle(
        fontSize: AppFontSize.headLine3.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get headline2 => myFontStyle(
        fontSize: AppFontSize.headLine2.toSp as double,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      );
  static TextStyle get headline1 => myFontStyle(
        fontSize: AppFontSize.headLine1.toSp as double,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      );
  static TextStyle get subTitle1 => myFontStyle(
        fontSize: AppFontSize.subTitle1.toSp as double,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      );
  static TextStyle get subTitle2 => myFontStyle(
        fontSize: AppFontSize.subTitle2.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );
  static TextStyle get bodyText1 => myFontStyle(
        fontSize: AppFontSize.bodyText1.toSp as double,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );
  static TextStyle get bodyText2 => myFontStyle(
        fontSize: AppFontSize.bodyText2.toSp as double,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
  static TextStyle get button => myFontStyle(
        fontSize: AppFontSize.button.toSp as double,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );
  static TextStyle get caption => myFontStyle(
        fontSize: AppFontSize.caption.toSp as double,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      );
  static TextStyle get overLine => myFontStyle(
        fontSize: AppFontSize.overLine.toSp as double,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      );
}

class AppFontSize {
  static const num headLine6 = 20;
  static const num headLine5 = 24;
  static const num headLine4 = 34;
  static const num headLine3 = 48;
  static const num headLine2 = 60;
  static const num headLine1 = 96;
  static const num subTitle1 = 16;
  static const num subTitle2 = 14;
  static const num bodyText1 = 16;
  static const num bodyText2 = 14;
  static const num button = 15;
  static const num caption = 12;
  static const num overLine = 10;
}

TextStyle myFontStyle({
  FontWeight? fontWeight,
  required double fontSize,
  double? letterSpacing,
}) {
  return TextStyle(
    fontFamily: "Campton",
    fontWeight: fontWeight,
    fontSize: ScreenUtil().setSp(fontSize),
    letterSpacing: letterSpacing,
  );
}

var appTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  displayMedium: GoogleFonts.poppins(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 48,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headlineSmall: myFontStyle(
    fontSize: 24.0.toSp as double,
    fontWeight: FontWeight.w500,
  ),
  titleLarge: myFontStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0.toSp as double,
    letterSpacing: 0.15,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: myFontStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: myFontStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.1,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelSmall: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
).apply(
  bodyColor: AppColors.textColor,
  displayColor: AppColors.textColor,
);
