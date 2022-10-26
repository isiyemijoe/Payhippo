import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyInputFormatter extends TextInputFormatter {
  static String clearCurrencyToNumberString(String value) {
    return value.replaceAll(RegExp('[^0-9]'), '');
  }

  static String _formatNumberToCurrency(String value) {
    final mValue = double.parse(value) / 100;
    return mValue.formatCurrencyWithoutSymbol;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return format(oldValue, newValue);
  }

  static TextEditingValue format(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var lastCursorPosition = -1;

    final cleanString = clearCurrencyToNumberString(newValue.text);
    try {
      final formattedAmount = _formatNumberToCurrency(cleanString);

      if (newValue.selection.start != newValue.text.length) {
        final int lengthDelta =
            max(0, formattedAmount.length - oldValue.text.length);
        final int newCursorOffset = max(
          0,
          min(formattedAmount.length, oldValue.selection.start + lengthDelta),
        );
        lastCursorPosition = newCursorOffset;
      } else {
        lastCursorPosition = formattedAmount.length;
      }

      return newValue.copyWith(
        text: formattedAmount,
        selection: TextSelection.collapsed(offset: lastCursorPosition),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return newValue;
  }
}

extension CurrencyUtil on num {
  static final f = NumberFormat('###,###,###,###,###,###,##0.00', 'en_NG');
  static final _f2 = NumberFormat('#,##0', 'en_NG');

  String get formatCurrencyWithoutSymbolAndDividing => f.format(this);

  String get formatCurrency => '₦ ${f.format(this)}';

  String get formatCurrencyWithoutSymbol => f.format(this);

  String get formatCurrencyWithoutLeadingZero => '₦ ${_f2.format(this)}';
}
