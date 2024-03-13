import 'package:flutter/widgets.dart';
import 'package:animated_icon_theme/animated_icon_theme.dart';
import 'package:animated_transform/animated_transform.dart';

class WxIcon extends Icon {
  /// Creates an animated icon
  const WxIcon(
    super.icon, {
    super.key,
    super.size,
    super.fill,
    super.weight,
    super.grade,
    super.opticalSize,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
    super.applyTextScaling,
    this.opacity = 1.0,
    this.scale = 1.0,
    this.rotate = 0.0,
    this.flipX = false,
    this.flipY = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  });

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// An opacity to apply to both explicit and default icon colors.
  final double opacity;

  /// Adjust the size of the icon relative to its original size.
  /// A value of 1 maintains the original size,
  /// while values greater than 1 enlarge
  /// and values less than 1 shrink the element.
  final double scale;

  /// Rotates icon by a specified number of degrees.
  /// Use a positive value for clockwise rotation
  /// or a negative value for counter-clockwise rotation.
  final double rotate;

  /// Controls whether the child widget is flipped horizontally (mirrored).
  /// Setting flipX to true will cause the child
  /// to be displayed as if reflected across a vertical axis.
  final bool flipX;

  /// Controls whether the child widget is flipped vertically (inverted).
  /// Setting flipY to true will cause the child
  /// to be displayed as if reflected across a horizontal axis.
  final bool flipY;

  @override
  Widget build(BuildContext context) {
    return AnimatedIconTheme(
      duration: duration,
      curve: curve,
      data: IconThemeData(
        color: color,
        opacity: opacity,
        size: size,
      ),
      child: AnimatedTransform(
        duration: duration,
        curve: curve,
        scale: scale,
        rotate: rotate,
        flipX: flipX,
        flipY: flipY,
        child: super.build(context),
      ),
    );
  }
}
