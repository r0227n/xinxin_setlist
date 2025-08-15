import 'package:flutter/material.dart';

/// Application UI constants and spacing definitions
///
/// This class provides a centralized location for all UI-related constants
/// used throughout the application. It follows Material Design principles
/// and ensures consistency across different screens and components.
///
/// The constants are organized into logical groups:
/// - Layout and spacing values
/// - Component dimensions
/// - Animation durations
/// - Border radius values
///
/// Example usage:
/// ```dart
/// Container(
///   padding: EdgeInsets.all(AppSpacing.medium),
///   child: Icon(
///     Icons.home,
///     size: AppIconSizes.medium,
///   ),
/// )
/// ```
abstract class AppSpacing {
  /// Private constructor to prevent instantiation
  const AppSpacing._();

  // Base spacing unit (8.0) following Material Design 8dp grid
  static const _baseUnit = 8.0;

  /// Extra small spacing (4.0)
  static const double extraSmall = _baseUnit / 2;

  /// Small spacing (8.0)
  static const double small = _baseUnit;

  /// Medium spacing (16.0)
  static const double medium = _baseUnit * 2;

  /// Large spacing (24.0)
  static const double large = _baseUnit * 3;

  /// Extra large spacing (32.0)
  static const double extraLarge = _baseUnit * 4;

  /// XXL spacing (48.0)
  static const double xxl = _baseUnit * 6.0;
}

/// Icon size constants following Material Design guidelines
abstract class AppIconSizes {
  /// Private constructor to prevent instantiation
  const AppIconSizes._();

  /// Small icon size (24.0)
  static const small = 24.0;

  /// Medium icon size (32.0)
  static const medium = 32.0;

  /// Large icon size (40.0)
  static const large = 40.0;

  /// Extra large icon size (48.0)
  static const extraLarge = 48.0;

  /// XXL icon size (64.0)
  static const xxl = 64.0;
}

/// Border radius constants for consistent rounded corners
abstract class AppBorderRadius {
  /// Private constructor to prevent instantiation
  const AppBorderRadius._();

  /// Small border radius (4.0)
  static const small = 4.0;

  /// Medium border radius (8.0)
  static const medium = 8.0;

  /// Large border radius (12.0)
  static const large = 12.0;

  /// Extra large border radius (16.0)
  static const extraLarge = 16.0;

  /// Circular border radius (999.0)
  static const circular = 999.0;
}

/// Animation duration constants for consistent motion
abstract class AppAnimationDurations {
  /// Private constructor to prevent instantiation
  const AppAnimationDurations._();

  /// Short animation duration (150ms)
  static const short = Duration(milliseconds: 150);

  /// Fast animation duration (200ms)
  static const fast = Duration(milliseconds: 200);

  /// Normal animation duration (300ms)
  static const normal = Duration(milliseconds: 300);

  /// Slow animation duration (500ms)
  static const slow = Duration(milliseconds: 500);
}

/// Layout-specific constants
abstract class AppLayout {
  /// Private constructor to prevent instantiation
  const AppLayout._();

  /// Breakpoint for large screen layout (800.0)
  static const largeScreenBreakpoint = 800.0;

  /// Desktop layout: Music info flex ratio
  static const desktopMusicInfoFlex = 3;

  /// Desktop layout: Setlist flex ratio
  static const desktopSetlistFlex = 7;

  /// Standard thumbnail size (200.0)
  static const thumbnailSize = 200.0;

  /// Card elevation value
  static const cardElevation = 4.0;
}

/// Component-specific spacing constants
abstract class AppComponentSpacing {
  /// Private constructor to prevent instantiation
  const AppComponentSpacing._();

  /// Badge vertical padding
  static const double badgeVertical = AppSpacing.extraSmall;

  /// Wrap widget spacing
  static const double wrap = AppSpacing.extraSmall;

  /// Card margin
  static const cardMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.medium,
    vertical: AppSpacing.small,
  );

  /// Standard button padding
  static const buttonPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.large,
    vertical: AppSpacing.medium,
  );
}
