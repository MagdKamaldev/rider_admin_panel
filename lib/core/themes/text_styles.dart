import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';

class TextStyles {
  static TextStyle normal = const TextStyle(
    color: AppColors.prussianBlue,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gotham'
  );
  static TextStyle headings = const TextStyle(
    color: AppColors.ivory,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Gotham'
  );
  static TextStyle tableHeadings = const TextStyle(
    color: Color.fromRGBO(23, 43, 77, 1),
    fontSize: 22,
    fontWeight: FontWeight.w500,
    fontFamily: 'Gotham'
  );
  static TextStyle tableRow = const TextStyle(
    color: Color.fromRGBO(23, 43, 77, 1),
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Gotham'
  );
}
