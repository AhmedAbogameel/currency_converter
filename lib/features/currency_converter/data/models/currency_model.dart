import 'dart:core';

import '../../domain/entities/currency.dart';

class CurrencyModel extends Currency {
  CurrencyModel({
    required super.countryName,
    required super.countryFlag,
    required super.currencyCode,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      countryName: json['name']['official'],
      countryFlag: json['flags']['png'],
      currencyCode: json['currencies'] == null ? 'USD' : (json['currencies'] as Map).entries.first.key,
    );
  }

  factory CurrencyModel.fromEntity(Currency entity) {
    return CurrencyModel(
      countryName: entity.countryName,
      countryFlag: entity.countryFlag,
      currencyCode: entity.currencyCode,
    );
  }

  Map<String, dynamic> get toJson => {
    'name': {'official': countryName},
    'flags': {'png': countryFlag},
    'currencies': {currencyCode: currencyCode},
  };

}
