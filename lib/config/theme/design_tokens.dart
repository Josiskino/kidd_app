import 'package:flutter/material.dart';

class DesignTokens {
  const DesignTokens._();

  static const double spaceXs = 4;
  static const double spaceS = 8;
  static const double spaceM = 12;
  static const double spaceL = 16;
  static const double spaceXl = 20;
  static const double spaceXxl = 24;
  static const double spaceXxxl = 32;

  static const double radiusS = 8;
  static const double radiusM = 12;
  static const double radiusL = 16;
  static const double radiusXl = 20;

  static const double heightButton = 48;
  static const double heightField = 48;

  static const Duration motionFast = Duration(milliseconds: 160);
  static const Duration motionNormal = Duration(milliseconds: 260);
  static const Duration motionSlow = Duration(milliseconds: 360);

  static const Curve curveEmphasized = Curves.easeOutCubic;

  static BorderRadius get radiusMedium => BorderRadius.circular(radiusM);
  static EdgeInsets get pagePadding => const EdgeInsets.all(spaceL);
  static EdgeInsets get cardPadding => const EdgeInsets.all(spaceL);
}
