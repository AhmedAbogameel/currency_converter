import 'package:equatable/equatable.dart';

class CurrencyConversion extends Equatable {
  final String from;
  final String to;
  final num amount;
  final num? result;

  CurrencyConversion({
    required this.from,
    required this.to,
    required this.amount,
    required this.result,
  });

  @override
  List<Object?> get props => [from, to, amount];

  factory CurrencyConversion.copyWith({
    required String from,
    required String to,
    required num amount,
    required num? result,
  }) {
    return CurrencyConversion(
      from: from,
      to: to,
      amount: amount,
      result: result,
    );
  }
}
