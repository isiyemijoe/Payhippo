import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';

enum IconAlignment { left, right }

class HippoButton extends StatelessWidget {
  const HippoButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.icon,
    this.buttonStyle,
    this.padding,
    this.elevation = 0,
    this.borderRadius,
    this.textStyle,
    this.iconAlignment = IconAlignment.left,
    this.iconMargin = 16,
  }) : super(key: key);

  final ButtonStyle? buttonStyle;
  final VoidCallback? onClick;
  final String text;
  final Widget? icon;
  final EdgeInsets? padding;
  final double? elevation;
  final double? borderRadius;
  final TextStyle? textStyle;
  final IconAlignment? iconAlignment;
  final double iconMargin;

  @override
  Widget build(BuildContext context) {
    var mButtonStyle = buttonStyle ?? AppThemes.primaryButtonStyle;

    if (null != padding) {
      mButtonStyle =
          mButtonStyle.copyWith(padding: MaterialStateProperty.all(padding));
    }

    if (elevation != null) {
      mButtonStyle = mButtonStyle.copyWith(
          elevation: MaterialStateProperty.all(elevation ?? 0));
    }

    if (borderRadius != null) {
      mButtonStyle = mButtonStyle.copyWith(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8))));
    }

    if (textStyle != null) {
      mButtonStyle = mButtonStyle.copyWith(
          textStyle: MaterialStateProperty.all(textStyle));
    }

    return button(buttonStyle: mButtonStyle, onClick: onClick);
  }

  List<Widget> _buildIconAndText() {
    final widgetTree = <Widget>[];
    final alignment = iconAlignment ?? IconAlignment.left;
    final hasIconLeft = alignment == IconAlignment.left && icon != null;
    final hasIconRight = alignment == IconAlignment.right && icon != null;

    if (hasIconLeft) {
      widgetTree
        ..add(icon!)
        ..add(SizedBox(width: iconMargin));
    }
    widgetTree.add(Flexible(child: Text(text)));

    if (hasIconRight) {
      widgetTree
        ..add(SizedBox(width: iconMargin))
        ..add(icon!);
    }
    return widgetTree;
  }

  Widget button({ButtonStyle? buttonStyle, VoidCallback? onClick}) {
    return ElevatedButton(
        style: buttonStyle,
        onPressed: onClick,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIconAndText()));
  }

  const factory HippoButton.sized({
    required String text,
    Stream<bool> state,
    ValueNotifier<bool>? isLoading,
    ButtonStyle? buttonStyle,
    EdgeInsets? padding,
    IconAlignment? iconAlignment,
    required VoidCallback? onClick,
    Widget? icon,
  }) = _SizedButton;

  const factory HippoButton.expanded({
    required String text,
    Stream<bool> state,
    ValueNotifier<bool>? isLoading,
    ButtonStyle? buttonStyle,
    EdgeInsets? padding,
    required VoidCallback? onClick,
    IconAlignment? iconAlignment,
    Widget? icon,
  }) = _ExpandedButton;

  const factory HippoButton.stream(
      {Key? key,
      required Stream<bool> state,
      required String text,
      required VoidCallback? onClick,
      EdgeInsets? padding,
      ValueNotifier<bool>? isLoading,
      ButtonStyle? buttonStyle,
      Widget? icon,
      IconAlignment? iconAlignment,
      TextStyle? textStyle}) = _AppStateFulButton;

  const factory HippoButton.image({
    Key? key,
    required VoidCallback? onClick,
    required Widget image,
    EdgeInsets padding,
    double elevation,
    Color? disabledColor,
    Color? backgroundColor,
    BorderRadius? radius,
    double? width,
    double? height,
  }) = _ImageButton;
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class _SizedButton extends HippoButton {
  const _SizedButton({
    required String text,
    required VoidCallback? onClick,
    ButtonStyle? buttonStyle,
    IconAlignment? iconAlignment,
    EdgeInsets? padding,
    this.state,
    this.isLoading,
    Widget? icon,
  }) : super(
            text: text,
            onClick: onClick,
            padding: padding,
            buttonStyle: buttonStyle,
            icon: icon,
            iconAlignment: iconAlignment);

  final Stream<bool>? state;
  final ValueNotifier<bool>? isLoading;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: (null == state)
          ? super.build(context)
          : _AppStateFulButton(
              text: text,
              state: state!,
              buttonStyle: buttonStyle,
              icon: icon,
              iconAlignment: iconAlignment,
              onClick: onClick,
              isLoading: isLoading,
            ),
    );
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class _ExpandedButton extends HippoButton {
  const _ExpandedButton(
      {required String text,
      required VoidCallback? onClick,
      ButtonStyle? buttonStyle,
      this.state,
      this.isLoading,
      Widget? icon,
      EdgeInsets? padding,
      IconAlignment? iconAlignment})
      : super(
            text: text,
            onClick: onClick,
            padding: padding,
            iconAlignment: iconAlignment,
            buttonStyle: buttonStyle,
            icon: icon);

  final Stream<bool>? state;
  final ValueNotifier<bool>? isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (null == state)
          ? super.build(context)
          : _AppStateFulButton(
              text: text,
              state: state!,
              buttonStyle: buttonStyle,
              icon: icon,
              iconAlignment: iconAlignment,
              onClick: onClick,
              isLoading: isLoading,
            ),
    );
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class _AppStateFulButton extends HippoButton {
  const _AppStateFulButton(
      {Key? key,
      required this.state,
      this.isLoading,
      this.shouldStretch = true,
      required String text,
      required VoidCallback? onClick,
      ButtonStyle? buttonStyle,
      Widget? icon,
      EdgeInsets? padding,
      IconAlignment? iconAlignment,
      TextStyle? textStyle})
      : super(
          key: key,
          iconAlignment: iconAlignment,
          icon: icon,
          padding: padding,
          onClick: onClick,
          text: text,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        );

  final Stream<bool> state;
  final ValueNotifier<bool>? isLoading;
  final bool shouldStretch;

  StreamBuilder<bool> _buttonStream(
      {ButtonStyle? buttonStyle,
      VoidCallback? onClick,
      required bool isLoading}) {
    return StreamBuilder(
        stream: state,
        builder: (ctx, AsyncSnapshot<bool> snapshot) {
          final enableButton =
              (snapshot.hasData && snapshot.data == true) && !isLoading;
          return Stack(
            children: [
              SizedBox(
                width: shouldStretch ? double.infinity : null,
                child: super.button(
                    buttonStyle: buttonStyle,
                    onClick: enableButton ? onClick : null),
              ),
              Positioned(
                  right: 16,
                  top: 16,
                  bottom: 16,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: AppColors.blue0,
                        )
                      : const SizedBox.shrink())
            ],
          );
        });
  }

  @override
  Widget button({ButtonStyle? buttonStyle, VoidCallback? onClick}) {
    return ValueListenableBuilder(
        valueListenable: isLoading ?? ValueNotifier(false),
        builder: (ctx, bool value, child) {
          return _buttonStream(
              buttonStyle: buttonStyle, onClick: onClick, isLoading: value);
        });
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class _ImageButton extends HippoButton {
  const _ImageButton({
    Key? key,
    required VoidCallback? onClick,
    required this.image,
    this.disabledColor,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
    double elevation = 0,
    EdgeInsets? padding,
  }) : super(
            key: key,
            text: "",
            onClick: onClick,
            padding: padding,
            elevation: elevation);

  final Widget image;
  final Color? disabledColor;
  final Color? backgroundColor;
  final BorderRadius? radius;
  final double? width;
  final double? height;

  List<BoxShadow> _buildElevation() {
    final boxShadows = <BoxShadow>[];
    if (elevation != null && elevation != 0) {
      boxShadows.add(BoxShadow(
          offset: Offset(0, elevation ?? 0),
          blurRadius: 1.5,
          color: Colors.grey.withOpacity(0.4)));
    }
    return boxShadows;
  }

  @override
  Widget button({ButtonStyle? buttonStyle, VoidCallback? onClick}) {
    return Container(
      decoration: BoxDecoration(
          color: (onClick != null)
              ? backgroundColor ?? AppColors.blue0
              : disabledColor ?? AppColors.grey.withOpacity(0.5),
          borderRadius: radius ?? const BorderRadius.all(Radius.circular(4)),
          boxShadow: _buildElevation()),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: radius ?? const BorderRadius.all(Radius.circular(4)),
          child: Container(
            width: width,
            height: height,
            padding: padding ?? const EdgeInsets.all(18.5),
            child: image,
          ),
        ),
      ),
    );
  }
}
