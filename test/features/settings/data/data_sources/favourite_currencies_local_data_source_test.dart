import 'dart:convert';

import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/features/settings/data/data_sources/favourite_currencies_local_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core_mocks/mock_get_storage.dart';

void main() {

  late MockGetStorage mockGetStorage;
  late FavouriteCurrenciesLocalDataSourceImpl localDataSourceImpl;

  final List<CurrencyModel> currencies = [
    CurrencyModel(countryName: 'a', countryFlag: 'b', currencyCode: 'c'),
    CurrencyModel(countryName: 'x', countryFlag: 'y', currencyCode: 'z'),
  ];

  final _databaseKey = 'favouriteCurrencies';

  setUp(() async {
    mockGetStorage = MockGetStorage();
    when(() => mockGetStorage.initStorage).thenAnswer((_) async => true);
    await mockGetStorage.initStorage;
    localDataSourceImpl = FavouriteCurrenciesLocalDataSourceImpl(
      getStorage: mockGetStorage,
    );
  });

  test(
    'should cache List of Currencies',
    () async {
      // arrange
      when(() => mockGetStorage.write(_databaseKey, anything)).thenAnswer((_) async => VoidCallback);
      // act
      final result = localDataSourceImpl.cacheFavouriteCurrencies;
      // assert
      expect(() => result(currencies: currencies), isA<VoidCallback>());
    },
  );

  test(
    'should get cached favourite currencies',
    () async {
      // arrange
      final List encodedCurrencies = [
        json.encode(CurrencyModel(countryName: 'a', countryFlag: 'b', currencyCode: 'c').toJson),
        json.encode(CurrencyModel(countryName: 'x', countryFlag: 'y', currencyCode: 'z').toJson),
      ];
      when(() => mockGetStorage.hasData(_databaseKey)).thenAnswer((_) => true);
      when(() => mockGetStorage.read(_databaseKey)).thenAnswer((_) => encodedCurrencies);
      // act
      final result = await localDataSourceImpl.getFavouriteCurrencies();
      // assert
      expect(result, equals(currencies));
    },
  );
}