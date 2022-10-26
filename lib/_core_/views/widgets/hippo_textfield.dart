import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:payhippo/_core_/utils/date_utils.dart';
import 'package:payhippo/_core_/utils/input_validation_state.dart';
import 'package:payhippo/_core_/utils/money_input_formatter.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';

typedef HippoDateRangeChange = void Function(DateTime? start, DateTime? end);
typedef HippoDateChange = void Function(DateTime? start);

class HippoDropdownTextField<T> extends StatelessWidget {
  const HippoDropdownTextField({
    super.key,
    required this.hintText,
    required this.options,
    required this.getLabel,
    required this.onChanged,
    this.value,
  });

  final String hintText;
  final List<T> options;
  final T? value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
        items: options.map((T value) {
          return DropdownMenuItem(
            value: value,
            child: Text(getLabel(value)),
          );
        }).toList(),
        onChanged: (newValue) {
          onChanged.call(newValue as T);
        },
        hint: Text(hintText),
        value: value,
        isExpanded: true,
        icon: Assets.vectors.caret.svg(),
      ),
    );
  }
}

class HippoTextField extends StatelessWidget {
  const HippoTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onClick,
    this.padding,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.autocorrect = true,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLength,
    this.isPassword = false,
    this.isDense = false,
    this.readOnly = false,
    this.showCursor = true,
    this.backgroundColor,
    this.textStyle,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.hintTextStyle,
    this.hintFontSize,
    this.hintFontWeight,
    this.hintTextColor,
    this.initialValue,
    this.borderRadius = 8,
    this.borderColor,
    this.focusedBorderColor,
    this.counterText,
    this.hintTextSize,
    this.onFocusChange,
  });

  const factory HippoTextField.stream({
    Key? key,
    required Stream<String?> valueStream,
    ValueChanged<String?> onChanged,
    TextEditingController? controller,
    String? hintText,
    String? initialValue,
    Color? focusedBorderColor,
    Color? borderColor,
    double borderRadius,
    Color? backgroundColor,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    EdgeInsets? padding,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter> inputFormatters,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    bool showCursor,
    bool readOnly,
    int? maxLength,
    String? counterText,
    double? hintFontSize,
  }) = _HippoStatefulField;

  const factory HippoTextField.amount({
    Key? key,
    required Stream<String?> valueStream,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    Color? textColor,
    double fontSize,
    FontWeight fontWeight,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextInputType? keyboardType,
    bool readOnly,
    bool showCursor,
    bool enableInteractiveSelection,
    String? hintText,
    String? initialValue,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
  }) = _HippoAmount;

  const factory HippoTextField.phone({
    Key? key,
    required Stream<String?> valueStream,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    Color? textColor,
    double fontSize,
    FontWeight fontWeight,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextInputType? keyboardType,
    bool readOnly,
    bool showCursor,
    bool enableInteractiveSelection,
    String? hintText,
    String? initialValue,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
  }) = _HippoPhoneField;

  const factory HippoTextField.date({
    Key? key,
    required BuildContext context,
    TextEditingController? controller,
    HippoDateChange? onDateSet,
    ValueChanged<String>? onChanged,
    String? hintText,
    EdgeInsets? padding,
    DateTime? startDate,
    String dateFormat,
  }) = _HippoDatePicker;

  const factory HippoTextField.dataRange({
    Key key,
    required BuildContext context,
    TextEditingController? controller,
    HippoDateRangeChange? onDateRangeSet,
    ValueChanged<String>? onChanged,
    String? hintText,
    EdgeInsets? padding,
    DateTime? startDate,
    DateTime? endDate,
    String dateFormat,
    double? hintFontSize,
    bool enableClearButton,
  }) = _HippoDateRangePicker;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClick;
  final EdgeInsets? padding;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enableSuggestions;
  final bool enableInteractiveSelection;
  final bool autocorrect;
  final bool? isPassword;
  final bool isDense;
  final bool readOnly;
  final bool showCursor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final String? initialValue;
  final FontWeight? hintFontWeight;
  final double? hintFontSize;
  final Color? hintTextColor;
  final double? hintTextSize;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? counterText;
  final int? maxLength;
  final ValueChanged<bool>? onFocusChange;

  Widget textField({
    required InputDecoration inputDecoration,
    TextEditingController? controller,
    bool? isPassword,
  }) {
    final _isPassword = isPassword ?? this.isPassword;
    return TextFormField(
      initialValue: initialValue,
      controller: controller ?? this.controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: _isPassword ?? obscureText,
      enableSuggestions: _isPassword ?? enableSuggestions,
      autocorrect: _isPassword ?? autocorrect,
      decoration: inputDecoration,
      showCursor: showCursor,
      readOnly: readOnly,
      maxLength: maxLength,
      onTap: onClick,
      enableInteractiveSelection: enableInteractiveSelection,
      style: textStyle ??
          TextStyle(
            fontWeight: fontWeight ?? FontWeight.normal,
            fontSize: fontSize ?? 16,
            color: textColor ?? AppColors.black,
          ),
    );
  }

  InputDecoration decoration({String? errorText, Widget? endIcon}) {
    return InputDecoration(
      isDense: isDense,
      filled: true,
      fillColor: backgroundColor ?? Colors.white,
      contentPadding: padding,
      errorText: errorText,
      labelText: labelText,
      hintText: hintText,
      hintStyle: hintTextStyle ??
          TextStyle(
            fontWeight: hintFontWeight ?? fontWeight ?? FontWeight.normal,
            fontSize: hintFontSize ?? fontSize ?? 13,
            color: hintTextColor ??
                textColor?.withOpacity(0.3) ??
                AppColors.black.withOpacity(0.3),
          ),
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      suffixIcon: endIcon ?? suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide:
            BorderSide(color: borderColor ?? AppColors.grey, width: 0.8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: focusedBorderColor ?? borderColor ?? AppColors.blue0,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: borderColor ?? AppColors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textField(
      inputDecoration: decoration(),
    );
  }
}

class _HippoAmount extends HippoTextField {
  const _HippoAmount({
    super.key,
    required this.valueStream,
    super.textColor,
    super.fontSize = 34,
    super.fontWeight = FontWeight.w700,
    super.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 21,
    ),
    super.controller,
    super.onChanged,
    super.backgroundColor = Colors.white,
    super.keyboardType = TextInputType.number,
    super.readOnly = false,
    super.enableInteractiveSelection = false,
    super.showCursor,
    super.hintText,
    super.initialValue,
    super.textStyle,
    super.hintTextStyle,
  });

  final Stream<String?> valueStream;

  @override
  String? get hintText => '0.00';

  @override
  TextStyle? get hintTextStyle => const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget? get prefixIcon => Padding(
        padding: EdgeInsets.only(
          left: padding?.left ?? 0,
          right: 12,
        ),
        child: Assets.vectors.naira.svg(width: 32, height: 26),
      );

  @override
  TextInputType? get keyboardType {
    if (Platform.isIOS && TextInputType.number == super.keyboardType) {
      return const TextInputType.numberWithOptions(signed: true);
    }
    return super.keyboardType;
  }

  @override
  List<TextInputFormatter>? get inputFormatters =>
      [FilteringTextInputFormatter.digitsOnly, MoneyInputFormatter()];

  @override
  Widget textField({
    required InputDecoration inputDecoration,
    TextEditingController? controller,
    bool? isPassword,
  }) {
    return StreamBuilder<String?>(
      stream: valueStream,
      builder: (context, snapshot) {
        final errorText = snapshot.hasError ? snapshot.error.toString() : null;

        return super.textField(
          inputDecoration: decoration(errorText: errorText),
          isPassword: isPassword,
          controller: super.controller?.withDefaultValueFromStream(
                snapshot,
                initialValue,
              ),
        );
      },
    );
  }
}

class _HippoDatePicker extends HippoTextField {
  const _HippoDatePicker({
    super.key,
    required this.context,
    super.controller,
    this.onDateSet,
    super.onChanged,
    super.hintText,
    EdgeInsets? padding,
    this.startDate,
    this.dateFormat = 'yyyy/MM/dd',
  })  : _padding = padding,
        super(
          isDense: true,
          showCursor: false,
          readOnly: true,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.none,
        );

  final HippoDateChange? onDateSet;
  final BuildContext context;
  final DateTime? startDate;
  final String dateFormat;
  final EdgeInsets? _padding;

  @override
  Color? get focusedBorderColor => AppColors.grey;

  @override
  EdgeInsets? get padding =>
      _padding ??
      const EdgeInsets.symmetric(vertical: 12) + const EdgeInsets.only(left: 8);

  @override
  Widget? get suffixIcon => Padding(
        padding: const EdgeInsetsDirectional.only(end: 8),
        child: Assets.vectors.icCalendar.svg(
          width: 24,
          height: 24,
          color: AppColors.black.withOpacity(0.2),
        ),
      );

  @override
  BoxConstraints? get suffixIconConstraints =>
      const BoxConstraints(minWidth: 24, minHeight: 24);

  @override
  VoidCallback? get onClick => _displayDatePicker;

  Future<void> _displayDatePicker() async {
    final firstDate = DateTime(1970);
    final lastDate = DateTime.now();

    final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: lastDate,
      initialDate: startDate ?? lastDate,
      helpText: '',
      cancelText: 'Close',
      confirmText: 'Done',
      builder: (context, child) {
        return Theme(
          data: context.theme.copyWith(
            brightness: Brightness.dark,
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      _onDateTimeChange(date);
    }
  }

  String _getFormattedDate(DateTime dateTime, {String? formatPattern}) {
    final format = formatPattern ?? dateFormat;
    return DateFormat(format).format(dateTime);
  }

  void _onDateTimeChange(DateTime date) {
    final formattedDate = _getFormattedDate(date);

    controller?.text = formattedDate;
    onChanged?.call(formattedDate);

    onDateSet?.call(date);
  }
}

class _HippoDateRangePicker extends HippoTextField {
  const _HippoDateRangePicker({
    super.key,
    required this.context,
    super.controller,
    super.onChanged,
    super.hintText,
    super.hintFontSize,
    EdgeInsets? padding,
    this.onDateRangeSet,
    this.startDate,
    this.endDate,
    this.dateFormat = 'yyyy/MM/dd',
    this.enableClearButton = false,
  })  : _padding = padding,
        super(
          isDense: true,
          showCursor: false,
          readOnly: true,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.none,
        );

  final HippoDateRangeChange? onDateRangeSet;
  final BuildContext context;
  final DateTime? startDate;
  final DateTime? endDate;
  final String dateFormat;
  final EdgeInsets? _padding;
  final bool enableClearButton;

  @override
  Color? get focusedBorderColor => AppColors.grey;

  @override
  EdgeInsets? get padding =>
      _padding ??
      const EdgeInsets.symmetric(vertical: 12) + const EdgeInsets.only(left: 8);

  bool get showClearButton {
    return enableClearButton && startDate != null && endDate != null;
  }

  @override
  Widget? get suffixIcon => Padding(
        padding: const EdgeInsetsDirectional.only(end: 8),
        child: showClearButton
            ? InkWell(
                onTap: _onClearDate,
                child: Icon(
                  Icons.cancel,
                  color: AppColors.black.withOpacity(0.2),
                ),
              )
            : Assets.vectors.icCalendar.svg(
                width: 24,
                height: 24,
                color: AppColors.black.withOpacity(0.2),
              ),
      );

  @override
  BoxConstraints? get suffixIconConstraints =>
      const BoxConstraints(minWidth: 24, minHeight: 24);

  @override
  VoidCallback? get onClick => _displayDatePicker;

  Future<void> _displayDatePicker() async {
    final firstDate = DateTime(1970);
    final lastDate = DateTime.now();

    DateTimeRange? initialDateRange;
    if (startDate != null && endDate != null) {
      initialDateRange = DateTimeRange(start: startDate!, end: endDate!);
    }

    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: lastDate,
      initialDateRange: initialDateRange,
      helpText: '',
      saveText: 'Done',
      builder: (context, child) {
        return Theme(
          data: context.theme.copyWith(
            brightness: Brightness.dark,
          ),
          child: child!,
        );
      },
    );

    if (dateRange != null) {
      _onDateTimeChange(dateRange);
    }
  }

  String _getFormattedDate(DateTime dateTime, {String? formatPattern}) {
    final format = formatPattern ?? dateFormat;
    return DateFormat(format).format(dateTime);
  }

  void _onDateTimeChange(DateTimeRange dateRange) {
    final startDateTime = dateRange.start;
    final endDateTime = dateRange.end.updateToMatchEndOfMoment();

    final formattedStartDate = _getFormattedDate(startDateTime);
    final formattedEndDate = _getFormattedDate(endDateTime);

    controller?.text = '$formattedStartDate ~ $formattedEndDate';
    onChanged?.call('$formattedStartDate|$formattedEndDate');

    onDateRangeSet?.call(startDateTime, endDateTime);
  }

  void _onClearDate() {
    controller?.text = '';
    onChanged?.call('');

    onDateRangeSet?.call(null, null);
  }
}

class _HippoPhoneEditText<T extends InputValidationState>
    extends HippoTextField {
  const _HippoPhoneEditText({
    super.key,
    this.validationStream,
    this.onFocusChange,
    super.onChanged,
    super.controller,
    this.countryCode = '+234',
  });

  final String countryCode;
  final Stream<T>? validationStream;
  final ValueChanged<bool>? onFocusChange;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(left: 16, right: 14);

  @override
  Widget? get prefixIcon => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.vectors.icPhone.svg(),
          const SizedBox(
            width: 8,
          ),
          Text(
            countryCode,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.black.withOpacity(0.7)),
          ),
          const SizedBox(
            width: 8.7,
          ),
          Container(
            height: 56,
            width: 0.6,
            color: borderColor?.withOpacity(0.3),
          )
        ],
      );

  Widget _buildEndIcon(AsyncSnapshot<T> snapshot) {
    InputValidationState? state = (snapshot.hasData) ? snapshot.data : null;
    return state?.render() ?? const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange,
      child: StreamBuilder<T>(
          stream: validationStream ?? const Stream.empty(),
          builder: (ctx, AsyncSnapshot<T> a) {
            final InputValidationState? state = (a.hasData) ? a.data : null;
            return super.textField(
                inputDecoration: decoration(
                    endIcon: _buildEndIcon(a), errorText: state?.errorMessage));
          }),
    );
  }
}

class _HippoPhoneField extends HippoTextField {
  const _HippoPhoneField({
    super.key,
    required this.valueStream,
    super.textColor,
    super.fontSize,
    super.fontWeight,
    super.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 21,
    ),
    super.controller,
    super.onChanged,
    super.backgroundColor = Colors.white,
    super.keyboardType = TextInputType.number,
    super.readOnly = false,
    super.enableInteractiveSelection = false,
    super.showCursor,
    super.hintText,
    super.initialValue,
    super.textStyle,
    super.hintTextStyle,
  }) : super(maxLength: 10);

  final Stream<String?> valueStream;

  @override
  TextStyle? get hintTextStyle => TextStyle(fontSize: 16);

  @override
  EdgeInsets? get padding => const EdgeInsets.only(left: 16, right: 14);

  @override
  Widget? get prefixIcon => Padding(
        padding: const EdgeInsets.only(left: 16, right: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.vectors.icPhone.svg(),
            const SizedBox(
              width: 8,
            ),
            const Text(
              '+234',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black),
            ),
            const SizedBox(
              width: 8.7,
            ),
            Container(
              height: 56,
              width: 0.6,
              color: borderColor?.withOpacity(0.3),
            )
          ],
        ),
      );

  @override
  Widget textField({
    required InputDecoration inputDecoration,
    TextEditingController? controller,
    bool? isPassword,
  }) {
    return StreamBuilder<String?>(
      stream: valueStream,
      builder: (context, snapshot) {
        final errorText = snapshot.hasError ? snapshot.error.toString() : null;
        return super.textField(
          inputDecoration: decoration(errorText: errorText),
          isPassword: isPassword,
          controller: super.controller?.withDefaultValueFromStream(
                snapshot,
                initialValue,
              ),
        );
      },
    );
  }
}

class _HippoStatefulField extends HippoTextField {
  const _HippoStatefulField({
    super.key,
    required this.valueStream,
    super.onChanged,
    super.controller,
    super.hintText,
    super.initialValue,
    super.focusedBorderColor,
    super.borderColor,
    super.borderRadius,
    super.backgroundColor = Colors.white,
    super.suffixIcon,
    super.suffixIconConstraints,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.padding,
    super.keyboardType = TextInputType.text,
    super.textInputAction,
    super.inputFormatters,
    super.textStyle,
    super.hintTextStyle,
    super.showCursor,
    super.readOnly = false,
    super.maxLength,
    super.counterText,
    super.hintFontSize,
  });

  final Stream<String?> valueStream;

  @override
  Widget textField({
    required InputDecoration inputDecoration,
    TextEditingController? controller,
    bool? isPassword,
  }) {
    return StreamBuilder<String?>(
      stream: valueStream,
      builder: (context, snapshot) {
        final errorText = snapshot.hasError ? snapshot.error.toString() : null;
        return super.textField(
          inputDecoration: decoration(errorText: errorText),
          isPassword: isPassword,
          controller: super.controller?.withDefaultValueFromStream(
                snapshot,
                initialValue,
              ),
        );
      },
    );
  }
}

extension TextEditing on TextEditingController {
  TextEditingController withDefaultValueFromStream(
    AsyncSnapshot<String?> snapshot,
    String? defaultValue,
  ) {
    if (!snapshot.hasData) return this;
    if (snapshot.hasError) {
      value = TextEditingValue(
        text: defaultValue ?? '',
        selection: TextSelection.collapsed(offset: defaultValue?.length ?? -1),
      );
      return this;
    }
    value = TextEditingValue(
      text: snapshot.data ?? '',
      selection: TextSelection.collapsed(offset: snapshot.data?.length ?? -1),
    );
    return this;
  }
}
