import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../currency_converter/domain/entities/currency.dart';
import '../repositories/favourite_currencies_repository.dart';

class CacheFavouriteCurrencies {
  final FavouriteCurrenciesRepository repository;

  CacheFavouriteCurrencies({required this.repository});

  Future<Either<Failure, void>> call({
    required List<Currency> currencies,
  }) {
    return repository.cacheFavouriteCurrencies(
      currencies: currencies,
    );
  }
}
