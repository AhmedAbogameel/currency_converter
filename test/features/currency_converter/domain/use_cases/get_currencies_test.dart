import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_currencies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_currencies_repository.dart';
import 'mock_currency_converter_repository.dart';

void main() {
  late MockCurrenciesRepository repository;
  late GetCurrencies getCurrencies;

  setUp(() {
    repository = MockCurrenciesRepository();
    getCurrencies = GetCurrencies(repository);
  });

  test(
    'should get list of currencies',
    () async {
      // arrange
      final currencies = [
        Currency(
          countryName: 'countryName',
          countryFlag: 'countryFlag',
          currencyCode: 'currencyCode',
        ),
      ];
      when(repository.getCurrencies).thenAnswer((_) async => Right(currencies));
      // act
      final r = await getCurrencies();
      // assert
      expect(r, equals(Right(currencies)));
    },
  );
}
