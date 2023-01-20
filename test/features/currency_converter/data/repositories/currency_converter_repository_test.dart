import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/errors/failure.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_conversion_model.dart';
import 'package:currency_converter/features/currency_converter/data/repositories/currency_converter_repository_impl.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_conversion.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_currency_converter_data_sources.dart';

void main() {
  late MockCurrencyConverterLocalDataSource localDataSource;
  late MockCurrencyConverterRemoteDataSource remoteDataSource;
  late CurrencyConverterRepositoryImpl repository;

  late CurrencyConversionModel conversionModel;
  late CurrencyConversion currencyConversion;

  setUp(() {
    localDataSource = MockCurrencyConverterLocalDataSource();
    remoteDataSource = MockCurrencyConverterRemoteDataSource();
    repository = CurrencyConverterRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    conversionModel = CurrencyConversionModel(
      result: null,
      amount: 100,
      to: 'A',
      from: 'B',
    );
    currencyConversion = CurrencyConversion(
      result: null,
      amount: 100,
      to: 'A',
      from: 'B',
    );
  });

  group('convert currency', () {
    test(
      'should convert currency successfully',
          () async {
        // arrange
        when(() => remoteDataSource.convertCurrency(conversionModel))
            .thenAnswer((_) async => conversionModel);
        // act
        final r = await repository.convertCurrency(conversionModel);
        // assert
        expect(r, equals(Right(conversionModel)));
      },
    );

    test(
      'should return failure when server unavailable',
          () async {
        // arrange
        when(() => remoteDataSource.convertCurrency(conversionModel))
            .thenThrow(ServerException(statusCode: 502));
        // act
        final r = await repository.convertCurrency(conversionModel);
        // assert
        expect(r, equals(Left(ServerFailure(statusCode: 502))));
      },
    );
  });

  test(
    'should cache conversion',
    () async {
      // arrange
      when(() => localDataSource.cacheCurrencyConversion(conversionModel))
          .thenAnswer((_) async => VoidCallback);
      // act
      final r = await repository.cacheConversionsHistory(currencyConversion);
      // assert
      verify(() => localDataSource.cacheCurrencyConversion(conversionModel));
      verifyNoMoreInteractions(localDataSource);
    },
  );

  test(
    'should get cached conversions',
    () async {
      // arrange
      final conversions = [conversionModel];
      when(localDataSource.getConversionsHistory)
          .thenAnswer((_) async => conversions);
      // act
      final r = await repository.getConversionsHistory();
      // assert
      expect(r, equals(Right(conversions)));
    },
  );

}
