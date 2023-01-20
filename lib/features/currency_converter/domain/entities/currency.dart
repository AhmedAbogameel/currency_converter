import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String countryName;
  final String countryFlag;
  final String currencyCode;

  Currency({
    required this.countryName,
    required this.countryFlag,
    required this.currencyCode,
  });

  @override
  List<Object?> get props => [
    countryName,
    countryFlag,
    currencyCode,
  ];
}
