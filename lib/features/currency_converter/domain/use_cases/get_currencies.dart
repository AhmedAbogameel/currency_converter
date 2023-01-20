import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/currency.dart';
import '../repositories/currencies_repository.dart';

class GetCurrencies {
  final CurrenciesRepository repository;

  GetCurrencies(this.repository);

  Future<Either<Failure, List<Currency>>> call() {
    return repository.getCurrencies();
  }
}
