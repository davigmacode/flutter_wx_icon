import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_icon_theme/animated_icon_theme.dart';
import 'package:widget_event/widget_event.dart';
import 'style.dart';
import 'theme.dart';
import '../icon.dart';

class WxToggleIcon extends StatelessWidget {
  const WxToggleIcon(
    this.icon, {
    Key? key,
    this.baseIcon,
    this.selected = false,
    this.disabled = false,
    this.style,
    this.curve,
    this.duration,
    this.eventsController,
  }) : super(key: key);

  /// The icon to display. The available icons are described in [Icons].
  final IconData icon;

  /// The alternate icon to display back of the main icon.
  /// Usually for outlined version of the main icon.
  final IconData? baseIcon;

  /// Whether or not this toggle icon is selected.
  ///
  /// Must not be null. Defaults to false.
  final bool selected;

  /// Whether or not this toggle icon is indeterminate.
  ///
  /// Must not be null. Defaults to false.
  final bool disabled;

  /// The style to be applied to the toggle icon.
  ///
  /// If [style] is an event driven [WxToggleIconStyle]
  /// by [WxDrivenToggleIconStyle], then [WxToggleIconStyle.evaluate]
  /// is used for the following [WxToggleIconEvent]s:
  ///
  ///  * [WxToggleIconEvent.selected].
  ///  * [WxToggleIconEvent.disabled].
  final WxToggleIconStyle? style;

  /// The curve to apply when animating the parameters of this widget.
  final Curve? curve;

  /// The duration over which to animate the parameters of this widget.
  final Duration? duration;

  /// Used by widgets that expose their internal event
  /// for the sake of extensions that add support for additional events.
  final WidgetEventController? eventsController;

  @override
  Widget build(BuildContext context) {
    final theme = WxToggleIconTheme.of(context);
    return _RenderToggleIcon(
      icon,
      baseIcon: baseIcon,
      curve: curve ?? theme.curve,
      duration: duration ?? theme.duration,
      style: theme.style.merge(style),
      selected: selected,
      disabled: disabled,
      eventsController: eventsController,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<IconData>('icon', icon));
    properties.add(DiagnosticsProperty<IconData>('backIcon', baseIcon));
    properties.add(DiagnosticsProperty<WxToggleIconStyle?>('style', style));
    properties.add(DiagnosticsProperty<bool>('selected', selected));
    properties.add(DiagnosticsProperty<bool>('disabled', disabled));
  }
}

class _RenderToggleIcon extends StatefulWidget {
  const _RenderToggleIcon(
    this.icon, {
    Key? key,
    required this.curve,
    required this.duration,
    required this.style,
    this.baseIcon,
    this.selected = false,
    this.disabled = false,
    this.eventsController,
  }) : super(key: key);

  final Curve curve;
  final Duration duration;
  final IconData icon;
  final IconData? baseIcon;
  final WxToggleIconStyle style;
  final bool selected;
  final bool disabled;
  final WidgetEventController? eventsController;

  @override
  State<_RenderToggleIcon> createState() => _RenderToggleIconState();
}

class _RenderToggleIconState extends State<_RenderToggleIcon>
    with WidgetEventMixin {
  WxToggleIconStyle style = const WxToggleIconStyle();

  @protected
  void setStyle() {
    final raw = widget.style;
    final res = WxDrivenToggleIconStyle.evaluate(raw, widgetEvents.value);
    style = WxToggleIconStyle.from(res);
  }

  @override
  void initState() {
    initWidgetEvents(widget.eventsController);
    widgetEvents.toggle(WidgetEvent.selected, widget.selected);
    widgetEvents.toggle(WidgetEvent.disabled, widget.disabled);
    setStyle();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(_RenderToggleIcon oldWidget) {
    if (mounted) {
      updateWidgetEvents(oldWidget.eventsController, widget.eventsController);
      widgetEvents.toggle(WidgetEvent.selected, widget.selected);
      widgetEvents.toggle(WidgetEvent.disabled, widget.disabled);
      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  void didChangeWidgetEvents() {
    if (mounted) {
      setStyle();
      super.didChangeWidgetEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedIconTheme(
          curve: widget.curve,
          duration: widget.duration,
          data: IconThemeData(
            color: style.baseColor,
            opacity: style.baseOpacity,
            size: style.size,
          ),
          child: Icon(widget.baseIcon ?? widget.icon),
        ),
        WxIcon(
          widget.icon,
          curve: widget.curve,
          duration: widget.duration,
          color: style.color,
          opacity: style.opacity ?? 1,
          scale: style.scale ?? 1,
          size: style.size,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    style.debugFillProperties(properties);
  }
}
