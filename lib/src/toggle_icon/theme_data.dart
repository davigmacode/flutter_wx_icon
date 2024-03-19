import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widget_event/widget_event.dart';
import 'style.dart';

/// Defines the visual properties of [ToggleIcon].
///
/// Descendant widgets obtain the current [WxToggleIconThemeData] object using
/// `ToggleIconTheme.of(context)`. Instances of [WxToggleIconThemeData]
/// can be customized with [WxToggleIconThemeData.copyWith] or [WxToggleIconThemeData.merge].
@immutable
class WxToggleIconThemeData extends ThemeExtension<WxToggleIconThemeData>
    with Diagnosticable {
  /// The curve to apply when animating the parameters of [ToggleIcon] widget.
  final Curve curve;

  /// The duration over which to animate the parameters of [ToggleIcon] widget.
  final Duration duration;

  /// The [WxToggleIconStyle] to be applied to the [ToggleIcon] widget
  final WxToggleIconStyle style;

  /// Creates a theme data that can be used for [ToggleIconTheme].
  const WxToggleIconThemeData({
    required this.curve,
    required this.duration,
    required this.style,
  });

  /// An [WxToggleIconThemeData] with some reasonable default values.
  static const fallback = WxToggleIconThemeData(
    curve: Curves.linear,
    duration: Duration(milliseconds: 200),
    style: WxToggleIconStyle(),
  );

  /// Creates a [WxToggleIconThemeData] from another one that probably null.
  WxToggleIconThemeData.from([WxToggleIconThemeData? other])
      : curve = other?.curve ?? fallback.curve,
        duration = other?.duration ?? fallback.duration,
        style = other?.style ?? fallback.style;

  /// A [WxToggleIconThemeData] with default values.
  factory WxToggleIconThemeData.defaults(BuildContext context) =>
      fallback.copyWith(
        style: WxDrivenToggleIconStyle.fade(
          baseColor: Theme.of(context).iconTheme.color,
          color: Theme.of(context).colorScheme.primary,
        ),
      );

  /// Creates a copy of this [WxToggleIconThemeData] but with
  /// the given fields replaced with the new values.
  @override
  WxToggleIconThemeData copyWith({
    Curve? curve,
    Duration? duration,
    WxToggleIconStyle? style,
  }) {
    return WxToggleIconThemeData(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      style: this.style.merge(style),
    );
  }

  /// Creates a copy of this [WxToggleIconThemeData] but with
  /// the given fields replaced with the new values.
  WxToggleIconThemeData merge(WxToggleIconThemeData? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      curve: other.curve,
      duration: other.duration,
      style: other.style,
    );
  }

  @override
  WxToggleIconThemeData lerp(
      ThemeExtension<WxToggleIconThemeData>? other, double t) {
    if (other is! WxToggleIconThemeData) return this;
    return WxToggleIconThemeData(
      curve: lerpEnum(curve, other.curve, t) ?? curve,
      duration: lerpEnum(duration, other.duration, t) ?? duration,
      style: WxToggleIconStyle.lerp(style, other.style, t) ?? style,
    );
  }

  Map<String, dynamic> toMap() => {
        'curve': curve,
        'duration': duration,
        'style': style,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is WxToggleIconThemeData && mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => Object.hashAll(toMap().values);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    toMap().entries.forEach((el) {
      properties.add(DiagnosticsProperty(el.key, el.value, defaultValue: null));
    });
  }
}
