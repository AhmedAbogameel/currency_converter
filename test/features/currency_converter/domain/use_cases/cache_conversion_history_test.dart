import 'package:currency_converter/features/currency_converter/domain/entities/currency_conversion.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/cache_conversion_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_currency_converter_repository.dart';

void main() {
  late MockCurrencyConverterRepository mockCurrencyConverterRepository;
  late CacheConversionHistory cacheConversionHistory;

  final currencyConversion = CurrencyConversion(
    from: 'EGP',
    to: 'USD',
    amount: 100,
    result: 100,
  );

  setUp(() {
    mockCurrencyConverterRepository = MockCurrencyConverterRepository();
    cacheConversionHistory = CacheConversionHistory(
      mockCurrencyConverterRepository
    );
  });

  test(
    'should cache given conversion',
    () async {
      // arrange
      when(() => mockCurrencyConverterRepository.cacheConversionsHistory(currencyConversion)).thenAnswer((_) async => Right(VoidCallback));
      // act
      await cacheConversionHistory(currencyConversion);
      // assert
      verify(() => mockCurrencyConverterRepository.cacheConversionsHistory(currencyConversion));
      verifyNoMoreInteractions(mockCurrencyConverterRepository);
    },
  );
}