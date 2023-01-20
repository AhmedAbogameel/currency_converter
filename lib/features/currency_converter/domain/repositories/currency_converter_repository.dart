import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/currency_conversion.dart';

abstract class CurrencyConverterRepository {
  Future<Either<Failure, CurrencyConversion>> convertCurrency(CurrencyConversion currencyConversion);
  Future<Either<Failure, List<CurrencyConversion>>> getConversionsHistory();
  Future<Either<Failure, void>> cacheConversionsHistory(CurrencyConversion currencyConversion);
}