// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Centralized color constants for the BeeChemApp
/// All colors used throughout the application should be defined here
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFF4D03F);
  static const Color primaryYellow = Color(0xfff2c208);

  // Background Colors
  static const Color scaffoldBackground = Colors.white;
  static const Color pageBackground = Color(0xfff5f7fa);
  static const Color lightGrayBackground = Color(0xfff5f5f5);
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color textHint = Colors.grey;
  static const Color textError = Colors.red;

  // Button Colors
  static const Color buttonPrimary = Color(0xFFF4D03F);
  static const Color buttonSecondary = Colors.black;
  static const Color buttonText = Colors.black;
  static const Color buttonTextSecondary = Colors.white;

  // Status Colors
  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  // Switch Colors
  static const Color switchActive = Colors.green;
  static Color switchInactive = Colors.grey.shade400;
  static const Color switchThumb = Colors.white;

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.05);

  // Icon Colors
  static Color iconGray = Colors.grey[700] ?? Colors.grey;

  // Checkbox Colors
  static const Color checkboxActive = Color(0xFFF4D03F);

  // Snackbar Colors
  static const Color snackbarError = Colors.red;

  // Loading Indicator Colors
  static const Color loadingIndicator = Colors.black;
  static const Color loadingIndicatorSecondary = Colors.white;

  // Logout Dialog Colors
  static Color logoutIconGradientStart = Color(0xFFF4D03F);
  static Color logoutIconGradientEnd = Color(0xFFF4D03F);
  static const Color logoutIconColor = Colors.black;
  static const Color logoutTitleColor = Colors.black;
  static Color logoutContentColor = Colors.grey.shade600;
  static Color logoutCancelBorderColor = Colors.grey.shade400;
  static Color logoutCancelBorderColorDisabled = Colors.grey.shade300;
  static Color logoutCancelTextColor = Colors.grey.shade700;
  static Color logoutCancelTextColorDisabled = Colors.grey.shade400;
  static Color logoutButtonBackground = Color(0xFFF4D03F);
  static Color logoutButtonBackgroundDisabled = Color(0xFFF4D03F);
  static const Color logoutButtonText = Colors.black;
  static Color logoutSnackbarBackground = Color(0xFFF4D03F);
  static const Color logoutDialogBackground = Colors.white;
  static Color logoutButtonShadow = Color(0xFFF4D03F).withOpacity(0.4);
}
