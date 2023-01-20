import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/settings/domain/use_cases/get_favourite_currencies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_favourite_currencies_repository.dart';

void main() {

  late GetFavouriteCurrencies getFavouriteCurrencies;
  late MockFavouriteCurrenciesRepository mockFavouriteCurrenciesRepository;

  setUp(() {
    mockFavouriteCurrenciesRepository = MockFavouriteCurrenciesRepository();
    getFavouriteCurrencies = GetFavouriteCurrencies(
      repository: mockFavouriteCurrenciesRepository,
    );
  });

  test('Should get List of Favourite Currencies', () async {
    // arrange
    final currencies = [
      Currency(countryName: 'name', countryFlag: 'image', currencyCode: 'currencyCode'),
      Currency(countryName: 'name1', countryFlag: 'image2', currencyCode: 'currencyCode3'),
    ];
    when(mockFavouriteCurrenciesRepository.getFavouriteCurrencies).thenAnswer((_) async => Right(currencies));
    // act
    final result = await getFavouriteCurrencies();
    // assert
    expect(result, equals(Right(currencies)));
  });

  test('Should not get failure if List of Favourite Currencies empty', () async {
    // arrange
    List<Currency> currencies = [];
    when(mockFavouriteCurrenciesRepository.getFavouriteCurrencies).thenAnswer((_) async => Right(currencies));
    // act
    final result = await getFavouriteCurrencies();
    // assert
    expect(result, equals(Right(currencies)));
  });

}