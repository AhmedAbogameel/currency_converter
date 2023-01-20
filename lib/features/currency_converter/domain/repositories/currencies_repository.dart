import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/currency.dart';

abstract class CurrenciesRepository {
  Future<Either<Failure, List<Currency>>> getCurrencies();
}