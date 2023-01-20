import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../currency_converter/domain/entities/currency.dart';
import '../repositories/favourite_currencies_repository.dart';

class GetFavouriteCurrencies {
  final FavouriteCurrenciesRepository repository;

  GetFavouriteCurrencies({required this.repository});

  Future<Either<Failure, List<Currency>>> call() {
    return repository.getFavouriteCurrencies();
  }
}
