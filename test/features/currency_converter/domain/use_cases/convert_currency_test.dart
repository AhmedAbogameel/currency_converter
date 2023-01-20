import 'package:currency_converter/core/errors/failure.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_conversion.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_currency_converter_repository.dart';

void main() {

  late MockCurrencyConverterRepository mockCurrencyConverterRepository;
  late ConvertCurrency convertCurrency;

  late CurrencyConversion currencyConversion;

  setUp(() {
    mockCurrencyConverterRepository = MockCurrencyConverterRepository();
    convertCurrency = ConvertCurrency(
        mockCurrencyConverterRepository
    );
    currencyConversion = CurrencyConversion(
      from: 'EGP',
      to: 'USD',
      amount: 100,
      result: 100,
    );
  });

  test(
    'should convert currency',
    () async {
      // arrange
      when(() => mockCurrencyConverterRepository.convertCurrency(currencyConversion))
      .thenAnswer((invocation) async => Right(currencyConversion));
      // act
      final r = await convertCurrency(currencyConversion);
      // assert
      verify(() => mockCurrencyConverterRepository.convertCurrency(currencyConversion));
      verifyNoMoreInteractions(mockCurrencyConverterRepository);
      expect(r, equals(Right(currencyConversion)));
    },
  );

  test(
    'should return server failure',
    () async {
      // arrange
      when(() => mockCurrencyConverterRepository.convertCurrency(currencyConversion))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final r = await convertCurrency(currencyConversion);
      // assert
      expect(r, equals(Left(ServerFailure())));
    },
  );

}