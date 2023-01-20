import '../../domain/entities/currency_conversion.dart';

class CurrencyConversionModel extends CurrencyConversion {
  CurrencyConversionModel({
    required super.from,
    required super.to,
    required super.amount,
    required super.result,
  });

  factory CurrencyConversionModel.fromJson(Map<String, dynamic> json) {
    return CurrencyConversionModel(
      result: json['result'],
      amount: json['query']['amount'],
      to: json['query']['to'],
      from: json['query']['from'],
    );
  }

  factory CurrencyConversionModel.fromEntity(CurrencyConversion entity) {
    return CurrencyConversionModel(
      result: entity.result,
      amount: entity.amount,
      to: entity.to,
      from: entity.from,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'query': {
        'amount': amount,
        'to': to,
        'from': from,
      }
    };
  }
}
