import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/settings/domain/use_cases/cache_favourite_currencies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_favourite_currencies_repository.dart';

void main() {
  late MockFavouriteCurrenciesRepository mockFavouriteCurrenciesRepository;
  late CacheFavouriteCurrencies cacheFavouriteCurrencies;

  setUp(() {
    mockFavouriteCurrenciesRepository = MockFavouriteCurrenciesRepository();
    cacheFavouriteCurrencies = CacheFavouriteCurrencies(
      repository: mockFavouriteCurrenciesRepository,
    );
  });

  test(
    'should cache currencies successfully',
    () async {
      // arrange
      final currencies = [
        Currency(countryName: 'name', countryFlag: 'image', currencyCode: 'currencyCode'),
      ];
      when(() => mockFavouriteCurrenciesRepository.cacheFavouriteCurrencies(
          currencies: currencies
      )).thenAnswer((_) async => Right(VoidCallback));
      // act
      await cacheFavouriteCurrencies(currencies: currencies);
      // assert
      verify(() => mockFavouriteCurrenciesRepository.cacheFavouriteCurrencies(currencies: currencies));
      verifyNoMoreInteractions(mockFavouriteCurrenciesRepository);
    },
  );

  test(
    'should not throw any cache failure even if list empty',
    () async {
      // arrange
      List<Currency> currencies = [];
      when(() => mockFavouriteCurrenciesRepository.cacheFavouriteCurrencies(
          currencies: currencies
      )).thenAnswer((_) async => Right(VoidCallback));
      // act
      await cacheFavouriteCurrencies(currencies: currencies);
      // assert
      verify(() => mockFavouriteCurrenciesRepository.cacheFavouriteCurrencies(currencies: currencies));
      verifyNoMoreInteractions(mockFavouriteCurrenciesRepository);
    },
  );
}