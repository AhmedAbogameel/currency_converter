import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../currency_converter/domain/entities/currency.dart';

abstract class FavouriteCurrenciesRepository {
  Future<Either<Failure, List<Currency>>> getFavouriteCurrencies();

  Future<Either<Failure, void>> cacheFavouriteCurrencies({
    required List<Currency> currencies,
  });
}
