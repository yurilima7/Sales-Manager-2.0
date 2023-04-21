import 'package:intl/intl.dart';

extension FormaterExtension on double {
  String get currencyPTBR {
    final currencyFormat = NumberFormat.currency(
      locale: 'pt_br',
      symbol: r'R$',
    );

    return currencyFormat.format(this);
  }
}

extension CurrencyFormatter on String {
  String removeCurrencyFormat() {
    return replaceAll('R\$', '').replaceAll(',', '.');
  }
}