import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_event/widget_event.dart';

/// The style to be applied to [ToggleIcon] widget
@immutable
class WxToggleIconStyle with Diagnosticable {
  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  final double? size;

  /// Scale the size of the icon.
  final double? scale;

  /// The color to use when drawing the icon.
  final Color? color;

  /// Opacity to be apply to [color].
  final double? opacity;

  /// The color to use when drawing the back icon.
  final Color? baseColor;

  /// Opacity to be apply to [baseColor].
  final double? baseOpacity;

  /// Create a style to be applied to [ToggleIcon] widget
  const WxToggleIconStyle({
    this.size,
    this.scale,
    this.color,
    this.opacity,
    this.baseColor,
    this.baseOpacity,
  });

  /// Create an [WxToggleIconStyle] from another style
  WxToggleIconStyle.from(WxToggleIconStyle? other)
      : size = other?.size,
        scale = other?.scale,
        color = other?.color,
        opacity = other?.opacity,
        baseColor = other?.baseColor,
        baseOpacity = other?.baseOpacity;

  /// Creates a copy of this [WxToggleIconStyle] but with
  /// the given fields replaced with the new values.
  WxToggleIconStyle copyWith({
    double? size,
    double? scale,
    Color? color,
    double? opacity,
    Color? baseColor,
    double? baseOpacity,
    bool? mergeResolved,
    WxToggleIconStyle? selectedStyle,
    WxToggleIconStyle? disabledStyle,
  }) {
    final style = WxToggleIconStyle(
      size: size ?? this.size,
      scale: scale ?? this.scale,
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
      baseColor: baseColor ?? this.baseColor,
      baseOpacity: baseOpacity ?? this.baseOpacity,
    );

    final hasEventStyle = [
      mergeResolved,
      selectedStyle,
      disabledStyle,
    ].any((el) => el != null);

    if (hasEventStyle) {
      return WxDrivenToggleIconStyle.from(
        style,
        selectedStyle: selectedStyle,
        disabledStyle: disabledStyle,
        mergeResolved: mergeResolved,
      );
    }
    return style;
  }

  /// Creates a copy of this [WxToggleIconStyle] but with
  /// the given fields replaced with the new values.
  WxToggleIconStyle merge(WxToggleIconStyle? other) {
    // if null return current object
    if (other == null) return this;

    var style = copyWith(
      size: other.size,
      scale: other.scale,
      color: other.color,
      opacity: other.opacity,
      baseColor: other.baseColor,
      baseOpacity: other.baseOpacity,
    );

    if (other is WxDrivenToggleIconStyle) {
      style = style.copyWith(
        selectedStyle: other.selectedStyle,
        disabledStyle: other.disabledStyle,
        mergeResolved: other.mergeResolved,
      );
    }

    return style;
  }

  /// Linearly interpolate between two [WxToggleIconStyle] objects.
  static WxToggleIconStyle? lerp(
      WxToggleIconStyle? a, WxToggleIconStyle? b, double t) {
    if (a == null && b == null) return null;
    return WxToggleIconStyle(
      size: lerpDouble(a?.size, b?.size, t),
      scale: lerpDouble(a?.scale, b?.scale, t),
      color: Color.lerp(a?.color, b?.color, t),
      opacity: lerpDouble(a?.opacity, b?.opacity, t),
      baseColor: Color.lerp(a?.baseColor, b?.baseColor, t),
      baseOpacity: lerpDouble(a?.baseOpacity, b?.baseOpacity, t),
    );
  }

  Map<String, dynamic> toMap() => {
        'size': size,
        'scale': scale,
        'color': color,
        'opacity': opacity,
        'outerColor': baseColor,
        'outerOpacity': baseOpacity,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is WxToggleIconStyle && mapEquals(other.toMap(), toMap());
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

/// A [WxToggleIconStyle] that change when some events occurs.
class WxDrivenToggleIconStyle extends WxToggleIconStyle
    implements DrivenProperty<WxToggleIconStyle?> {
  /// Whether the resolved style is merged to
  /// the previous resolved style or not
  final bool? mergeResolved;

  /// The [selectedStyle] is style to be resolved when
  /// events includes [WidgetEvent.selected].
  final WxToggleIconStyle? selectedStyle;

  /// The [disabledStyle] style to be resolved when
  /// events includes [WidgetEvent.disabled].
  final WxToggleIconStyle? disabledStyle;

  /// Map of driven style, order matters
  Map<WidgetEvent, WxToggleIconStyle?> get driven => {
        WidgetEvent.selected: selectedStyle,
        WidgetEvent.disabled: disabledStyle,
      };

  /// Create a [WxToggleIconStyle] that change when some events occurs.
  const WxDrivenToggleIconStyle({
    super.size,
    super.scale,
    super.color,
    super.opacity,
    super.baseColor,
    super.baseOpacity,
    this.selectedStyle,
    this.disabledStyle,
    this.mergeResolved,
  });

  /// Create a [WxDrivenToggleIconStyle] with value
  /// from another [WxToggleIconStyle].
  WxDrivenToggleIconStyle.from(
    WxToggleIconStyle? enabled, {
    this.selectedStyle,
    this.disabledStyle,
    this.mergeResolved,
  }) : super.from(enabled);

  WxDrivenToggleIconStyle.fade({
    super.size,
    super.color,
    super.baseColor,
    WxToggleIconStyle? selectedStyle,
    this.disabledStyle,
  })  : mergeResolved = true,
        selectedStyle = const WxToggleIconStyle(
          scale: 1,
          opacity: 1,
          baseOpacity: .8,
        ).merge(selectedStyle),
        super(
          scale: 1,
          opacity: 0,
          baseOpacity: .8,
        );

  WxDrivenToggleIconStyle.scaleUp({
    super.size,
    super.color,
    super.baseColor,
    WxToggleIconStyle? selectedStyle,
    this.disabledStyle,
  })  : mergeResolved = true,
        selectedStyle = const WxToggleIconStyle(
          scale: 1,
          opacity: 1,
          baseOpacity: .8,
        ).merge(selectedStyle),
        super(
          scale: 0,
          opacity: 0,
          baseOpacity: .8,
        );

  WxDrivenToggleIconStyle.scaleDown({
    super.size,
    super.color,
    super.baseColor,
    WxToggleIconStyle? selectedStyle,
    this.disabledStyle,
  })  : mergeResolved = true,
        selectedStyle = const WxToggleIconStyle(
          scale: 1,
          opacity: 1,
          baseOpacity: .8,
        ).merge(selectedStyle),
        super(
          scale: 3,
          opacity: 0,
          baseOpacity: .8,
        );

  /// Create a [WxDrivenToggleIconStyle] from a resolver callback
  WxDrivenToggleIconStyle.resolver(
    DrivenPropertyResolver<WxToggleIconStyle?> resolver, {
    this.mergeResolved = false,
  })  : selectedStyle = resolver({WidgetEvent.selected}),
        disabledStyle = resolver({WidgetEvent.disabled}),
        super.from(resolver({}));

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxToggleIconStyle],
  /// otherwise returns the value itself.
  static WxToggleIconStyle? evaluate(
    WxToggleIconStyle? value,
    Set<WidgetEvent> events,
  ) =>
      DrivenProperty.evaluate<WxToggleIconStyle?>(value, events);

  @override
  WxToggleIconStyle resolve(Set<WidgetEvent> events) {
    WxToggleIconStyle style = this;
    for (var e in driven.entries) {
      if (events.contains(e.key)) {
        final evaluated = evaluate(e.value, events);
        style = mergeResolved != false
            ? style.merge(evaluated)
            : WxToggleIconStyle.from(evaluated);
      }
    }
    return style;
  }

  /// Creates a copy of this [WxToggleIconStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxDrivenToggleIconStyle copyWith({
    double? size,
    double? scale,
    Color? color,
    double? opacity,
    Color? baseColor,
    double? baseOpacity,
    bool? mergeResolved,
    WxToggleIconStyle? selectedStyle,
    WxToggleIconStyle? disabledStyle,
  }) {
    return WxDrivenToggleIconStyle(
      size: size ?? this.size,
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
      scale: scale ?? this.scale,
      baseColor: baseColor ?? this.baseColor,
      baseOpacity: baseOpacity ?? this.baseOpacity,
      mergeResolved: mergeResolved ?? this.mergeResolved,
      selectedStyle: this.selectedStyle?.merge(selectedStyle) ?? selectedStyle,
      disabledStyle: this.disabledStyle?.merge(disabledStyle) ?? disabledStyle,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('mergeResolved', mergeResolved));
    properties.add(DiagnosticsProperty('selectedStyle', selectedStyle));
    properties.add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }
}
