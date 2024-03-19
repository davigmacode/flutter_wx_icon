import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';

/// A Widget that controls how descendant toggle icon should look like.
class WxToggleIconTheme extends InheritedTheme {
  /// The properties for descendant [ToggleIcon]s
  final WxToggleIconThemeData data;

  /// Creates a theme that controls
  /// how descendant toggle icon should look like.
  const WxToggleIconTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// Creates an [WxToggleIconTheme] that controls the style of
  /// descendant widgets, and merges in the current [WxToggleIconTheme], if any.
  ///
  /// The [child] arguments must not be null.
  static Widget merge({
    Key? key,
    Curve? curve,
    Duration? duration,
    WxToggleIconStyle? style,
    WxToggleIconThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = WxToggleIconTheme.of(context);
        return WxToggleIconTheme(
          key: key,
          data: parent.merge(data).copyWith(
                curve: curve,
                duration: duration,
                style: style,
              ),
          child: child,
        );
      },
    );
  }

  /// The [WxToggleIconTheme] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ToggleIconThemeData theme = ToggleIconTheme.of(context);
  /// ```
  static WxToggleIconThemeData of(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<WxToggleIconTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<WxToggleIconThemeData>();
    final defaultTheme = WxToggleIconThemeData.defaults(context);
    return defaultTheme.merge(globalTheme);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return WxToggleIconTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(WxToggleIconTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WxToggleIconThemeData>('data', data));
  }
}
