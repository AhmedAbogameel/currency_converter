import 'package:currency_converter/features/currency_converter/domain/entities/currency_conversion.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_conversions_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_currency_converter_repository.dart';

void main() {

  late MockCurrencyConverterRepository mockCurrencyConverterRepository;
  late GetConversionsHistory getConversionsHistory;

  final conversions = [
    CurrencyConversion(
      from: 'EGP',
      to: 'USD',
      amount: 100,
      result: 100,
    )
  ];

  setUp(() {
    mockCurrencyConverterRepository = MockCurrencyConverterRepository();
    getConversionsHistory = GetConversionsHistory(
      mockCurrencyConverterRepository
    );
  });

  test(
    'should get cached conversions',
    () async {
      // arrange
      when(mockCurrencyConverterRepository.getConversionsHistory).thenAnswer((_) async => Right(conversions));
      // act
      final result = await getConversionsHistory();
      // assert
      verify(mockCurrencyConverterRepository.getConversionsHistory);
      verifyNoMoreInteractions(mockCurrencyConverterRepository);
      expect(result, equals(Right(conversions)));
    },
  );

  test(
    'should get empty conversions not throwing failure',
    () async {
      // arrange
      List<CurrencyConversion> conversions = [];
      when(mockCurrencyConverterRepository.getConversionsHistory).thenAnswer((_) async => Right(conversions));
      // act
      final result = await getConversionsHistory();
      // assert
      verify(mockCurrencyConverterRepository.getConversionsHistory);
      verifyNoMoreInteractions(mockCurrencyConverterRepository);
      expect(result, equals(Right(conversions)));
    },
  );



}