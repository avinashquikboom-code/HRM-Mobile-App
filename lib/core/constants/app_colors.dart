import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette
  static const Color primary = Color(0xFF3BA38B);
  static const Color primaryDark = Color(0xFF2B7D6B);
  static const Color primaryLight = Color(0xFF5FC5AE);
  static const Color secondary = Color(0xFF5FC5AE); // Added back for compatibility
  static const Color accent = Color(0xFFF4B860);
  
  static const Color background = Color(0xFFF6F9F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // HR Specific
  static const Color hrPrimary = Color(0xFF2B7D6B);
  static const Color hrPrimaryLight = Color(0xFF3BA38B); // Added back for compatibility
  static const Color hrAccent = Color(0xFFF4B860);
  
  static const LinearGradient hrGradient = LinearGradient(
    colors: [Color(0xFF2B7D6B), Color(0xFF3BA38B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Employee Specific
  static const Color empPrimary = Color(0xFF3BA38B);
  static const Color empAccent = Color(0xFF5FC5AE);

  static const LinearGradient empGradient = LinearGradient(
    colors: [Color(0xFF3BA38B), Color(0xFF5FC5AE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Global Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphism Utility
  static LinearGradient glassGradient(Color color) => LinearGradient(
    colors: [
      color.withValues(alpha: 0.15),
      color.withValues(alpha: 0.05),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}
