import 'package:flutter/material.dart';
import 'app_colors.dart'; // Apnar app_colors.dart import korben

/// Application Typography / Text Styles definition
class AppTypography {
  AppTypography._(); // Private constructor to prevent instantiation

  // Base Font Family (Jodi custom Google font use korben, ekhane set korte paren)
  static const String fontFamily = 'Poppins'; // Ba Inter / Roboto

  // ===========================================================================
  // HEADINGS (Headers, Title, Page Names)
  // ===========================================================================

  /// H1 / Large Title (Welcome Screen, Dynamic App Header)
  static const TextStyle h1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: fontFamily,
    height: 1.2,
  );

  /// H2 / Screen Sub-Title (Card Titles like 'Login', 'Sign Up')
  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.authText,
    fontFamily: fontFamily,
  );

  /// H3 / Section Header
  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    fontFamily: fontFamily,
  );

  // ===========================================================================
  // BODY TEXT (Paragraphs, Form Labels, Field Texts)
  // ===========================================================================

  /// Standard Body Text / TextField Input Text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    fontFamily: fontFamily,
  );

  /// TextField Label / Hint Text
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    fontFamily: fontFamily,
  );

  /// Small Text / Footer Text (e.g. "Don't have an account?")
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    fontFamily: fontFamily,
  );

  // ===========================================================================
  // BUTTONS & LINKS (CTA, Clickable Items)
  // ===========================================================================

  /// Main Action Buttons (AuthButton, GradientButton)
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: fontFamily,
  );

  /// Text Buttons / Clickable Action Text (e.g. "Forgot Password?", "Sign Up")
  static const TextStyle actionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.authText,
    fontFamily: fontFamily,
  );
}