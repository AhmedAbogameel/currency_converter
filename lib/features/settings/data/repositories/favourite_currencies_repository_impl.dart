import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../currency_converter/data/models/currency_model.dart';
import '../../../currency_converter/domain/entities/currency.dart';
import '../../domain/repositories/favourite_currencies_repository.dart';
import '../data_sources/favourite_currencies_local_data_source.dart';

class FavouriteCurrenciesRepositoryImpl
    implements FavouriteCurrenciesRepository {
  final FavouriteCurrenciesLocalDataSource localDataSource;

  FavouriteCurrenciesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> cacheFavouriteCurrencies({
    required List<Currency> currencies,
  }) async {
    try {
      final result = await localDataSource.cacheFavouriteCurrencies(
        currencies: currencies.map((e) => CurrencyModel.fromEntity(e)).toList(),
      );
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, List<Currency>>> getFavouriteCurrencies() async {
    try {
      final result = await localDataSource.getFavouriteCurrencies();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure);
    }
  }
}
