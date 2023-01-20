import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/errors/failure.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/features/currency_converter/data/repositories/currencies_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_currencies_data_sources.dart';

void main() {
  late MockCurrenciesLocalDataSource localDataSource;
  late MockCurrenciesRemoteDataSource remoteDataSource;
  late CurrenciesRepositoryImpl repository;

  final List<CurrencyModel> currencies = [
    CurrencyModel(
      countryName: 'countryName',
      countryFlag: 'countryFlag',
      currencyCode: 'currencyCode',
    ),
  ];

  setUp(() {
    localDataSource = MockCurrenciesLocalDataSource();
    remoteDataSource = MockCurrenciesRemoteDataSource();
    repository = CurrenciesRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );
  });

  test(
    'should get currencies from remote data source then cache it',
    () async {
      // arrange
      when(remoteDataSource.getCurrencies)
          .thenAnswer((_) async => currencies);
      when(() => localDataSource.cacheCurrencies(currencies))
          .thenAnswer((_) async => VoidCallback);
      when(localDataSource.getCurrencies)
          .thenAnswer((_) async => null);
      // act
      final result = await repository.getCurrencies();
      // assert
      expect(result, equals(Right(currencies)));
      verify(remoteDataSource.getCurrencies);
      verify(() => localDataSource.cacheCurrencies(currencies));
    },
  );

  test(
    'should get currencies from local ds if exists and no interaction on remote',
    () async {
      // arrange
      when(localDataSource.getCurrencies)
          .thenAnswer((_) async => currencies);
      // act
      final result = await repository.getCurrencies();
      // assert
      verifyZeroInteractions(remoteDataSource);
      expect(result, equals(Right(currencies)));
    },
  );

  test(
    'should return failure when server or internet is unavailable',
    () async {
      // arrange
      when(localDataSource.getCurrencies)
          .thenAnswer((_) async => null);
      when(remoteDataSource.getCurrencies)
          .thenThrow(ServerException(statusCode: 500));
      // act
      final r = await repository.getCurrencies();
      // assert
      expect(r, Left(ServerFailure(statusCode: 500)));
    },
  );
}
