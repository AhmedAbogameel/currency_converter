import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/currency_conversion.dart';
import '../repositories/currency_converter_repository.dart';

class CacheConversionHistory {
  final CurrencyConverterRepository repository;

  CacheConversionHistory(this.repository);

  Future<Either<Failure, void>> call(CurrencyConversion currencyConversion) {
    return repository.cacheConversionsHistory(currencyConversion);
  }
}