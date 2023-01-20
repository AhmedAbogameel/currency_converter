import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/currency_conversion.dart';
import '../../domain/repositories/currency_converter_repository.dart';
import '../data_sources/currency_converter_local_data_source.dart';
import '../data_sources/currency_converter_remote_data_source.dart';
import '../models/currency_conversion_model.dart';

class CurrencyConverterRepositoryImpl implements CurrencyConverterRepository {
  final CurrencyConverterRemoteDataSource remoteDataSource;
  final CurrencyConverterLocalDataSource localDataSource;

  CurrencyConverterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CurrencyConversion>> convertCurrency(
      CurrencyConversion currencyConversion) async {
    try {
      final result = await remoteDataSource.convertCurrency(currencyConversion);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, List<CurrencyConversion>>> getConversionsHistory() async {
    try {
      final result = await localDataSource.getConversionsHistory();
      return Right(result);
    } on AppException catch(e) {
      return Left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, void>> cacheConversionsHistory(CurrencyConversion currencyConversion) async {
    try {
      final result = await localDataSource.cacheCurrencyConversion(CurrencyConversionModel.fromEntity(currencyConversion));
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure);
    }
  }
}
