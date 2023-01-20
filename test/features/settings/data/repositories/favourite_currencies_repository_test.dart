import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/features/settings/data/repositories/favourite_currencies_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_favourite_currencies_local_data_source.dart';

void main() {
  late MockFavouriteCurrenciesLocalDataSource mockDataSource;
  late FavouriteCurrenciesRepositoryImpl repositoryImpl;

  setUp(() {
    mockDataSource = MockFavouriteCurrenciesLocalDataSource();
    repositoryImpl = FavouriteCurrenciesRepositoryImpl(
      localDataSource: mockDataSource,
    );
  });

  final currencies = [
    CurrencyModel(countryName: 'name', countryFlag: 'image', currencyCode: 'currencyCode'),
  ];

  test(
    'should get favourites currencies',
    () async {
      // arrange
      when(mockDataSource.getFavouriteCurrencies).thenAnswer((_) async => currencies);
      // act
      final result = await repositoryImpl.getFavouriteCurrencies();
      // assert
      expect(result, equals(Right(currencies)));
    },
  );

  test(
    'should cache currencies without errors',
    () async {
      // arrange
      when(() => mockDataSource.cacheFavouriteCurrencies(currencies: currencies)).thenAnswer((_) async => VoidCallback);
      // act
      await repositoryImpl.cacheFavouriteCurrencies(currencies: currencies);
      // assert
      verify(() => mockDataSource.cacheFavouriteCurrencies(currencies: currencies));
      verifyNoMoreInteractions(mockDataSource);
    },
  );
}