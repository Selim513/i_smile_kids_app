import 'package:flutter/material.dart';

abstract class ColorManager {
  // Main brand colors
  static const Color primary = Color(0xFF31C3BD); // Teal
  static const Color secondary = Color(0xFFFFB703); // Amber
  static const Color accent = Color(0xFF8A5CF6); // Purple
  static const Color greyColor = Color(0xffCCCCCC); // Purple

  // Status colors
  static const Color success = Color(0xFF22C55E); // Green
  static const Color error = Color(0xFFEF4444); // Red
  static const Color warning = Color(0xFFF59E0B); // Orange

  // Neutral / UI
  static const Color textDark = Color(0xFF1F2937); // Dark gray
  static const Color textLight = Color(0xFFFFFFFF); // White
  static const Color background = Color(0xFFF8FAFC); // Light gray background
  static const Color card = Color(0xFFFFFFFF); // Card background white
  static const Color border = Color(0xFFE5E7EB); // Divider / Border gray
}
