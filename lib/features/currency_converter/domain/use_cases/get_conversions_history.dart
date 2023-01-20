
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/currency_conversion.dart';
import '../repositories/currency_converter_repository.dart';

class GetConversionsHistory {
  final CurrencyConverterRepository repository;

  GetConversionsHistory(this.repository);

  Future<Either<Failure, List<CurrencyConversion>>> call() {
    return repository.getConversionsHistory();
  }
}