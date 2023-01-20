import 'dart:convert';

import 'package:currency_converter/features/currency_converter/data/data_sources/currencies_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core_mocks/mock_get_storage.dart';

void main() {
  late CurrenciesLocalDataSourceImpl localDataSource;
  late MockGetStorage mockGetStorage;
  final _databaseKey = 'currencies';

  List<CurrencyModel> currencies = [
    CurrencyModel(
      countryName: 'a',
      currencyCode: 'b',
      countryFlag: 'c',
    )
  ];

  final encodedCurrencies = jsonEncode([
    CurrencyModel(
      countryName: 'a',
      currencyCode: 'b',
      countryFlag: 'c',
    ).toJson,
  ]);

  setUp(() {
    mockGetStorage = MockGetStorage();
    localDataSource = CurrenciesLocalDataSourceImpl(
      getStorage: mockGetStorage,
    );
  });

  test(
    'should get cached currencies',
    () async {
      // arrange
      when(() => mockGetStorage.hasData(_databaseKey))
          .thenAnswer((_) => true);

      when(() => mockGetStorage.read(_databaseKey))
          .thenAnswer((_) => encodedCurrencies);
      // act
      final r = await localDataSource.getCurrencies();
      // assert
      expect(r, equals(currencies));
    },
  );

  test(
    'should cache List of currencies',
    () async {
      // arrange
      when(() => mockGetStorage.write(_databaseKey, encodedCurrencies))
          .thenAnswer((_) async => VoidCallback);
      // act
      await localDataSource.cacheCurrencies(currencies);
      // assert
      verify(() => mockGetStorage.write(_databaseKey, encodedCurrencies));
    },
  );
}
