import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/currency.dart';
import '../../domain/repositories/currencies_repository.dart';
import '../data_sources/currencies_local_data_source.dart';
import '../data_sources/currencies_remote_data_source.dart';

class CurrenciesRepositoryImpl implements CurrenciesRepository {

  final CurrenciesRemoteDataSource remoteDataSource;
  final CurrenciesLocalDataSource localDataSource;

  CurrenciesRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<Currency>>> getCurrencies() async {
    try {
      final localCurrencies = await localDataSource.getCurrencies();
      if (localCurrencies != null) {
        return Right(localCurrencies);
      }
      final currencies = await remoteDataSource.getCurrencies();
      localDataSource.cacheCurrencies(currencies);
      return Right(currencies);
    } on AppException catch (e) {
      return Left(e.toFailure);
    }
  }

}