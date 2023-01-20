import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/currency_conversion.dart';
import '../repositories/currency_converter_repository.dart';

class ConvertCurrency {
  final CurrencyConverterRepository repository;

  ConvertCurrency(this.repository);

  Future<Either<Failure, CurrencyConversion>> call(
      CurrencyConversion currencyConversion) {
    return repository.convertCurrency(currencyConversion);
  }
}
