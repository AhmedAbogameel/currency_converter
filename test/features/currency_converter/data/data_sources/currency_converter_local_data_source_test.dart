import 'dart:convert';

import 'package:currency_converter/features/currency_converter/data/data_sources/currency_converter_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_conversion_model.dart';
import 'package:currency_converter/features/currency_converter/data/repositories/currency_converter_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core_mocks/mock_get_storage.dart';

void main() {
  late CurrencyConverterLocalDataSourceImpl localDataSource;
  late MockGetStorage mockGetStorage;

  late List encodedConversions;

  final _databaseKey = 'conversionHistory';

  List<CurrencyConversionModel> conversions = [
    CurrencyConversionModel(from: 'f', to: 't', amount: 1, result: null),
  ];

  final dateTime = DateTime.now();

  setUp(() {
    mockGetStorage = MockGetStorage();
    localDataSource = CurrencyConverterLocalDataSourceImpl(
      getStorage: mockGetStorage,
    );
  });


  void arrangeGetCachedTests() {
    when(() => mockGetStorage.hasData(_databaseKey)).thenAnswer((_) => true);
    when(() => mockGetStorage.write(_databaseKey, any())).thenAnswer((_) async => VoidCallback);
    when(() => mockGetStorage.read(_databaseKey))
        .thenAnswer((_) => encodedConversions);
  }

  test(
    'should get cached conversions',
    () async {
      // arrange
      encodedConversions = [
        jsonEncode(CurrencyConversionModel(
          from: 'f',
          to: 't',
          amount: 1,
          result: null,
        ).toJson()..addAll({
          'created_at': dateTime.millisecondsSinceEpoch,
        })),
      ];
      arrangeGetCachedTests();
      // act
      final r = await localDataSource.getConversionsHistory();
      // assert
      expect(r, equals(conversions));
    },
  );

  test(
    'should get cached conversions until 7 days only',
    () async {
      // arrange
      encodedConversions = [
        jsonEncode(CurrencyConversionModel(
          from: 'f',
          to: 't',
          amount: 1,
          result: null,
        ).toJson()..addAll({
          'created_at': dateTime.subtract(Duration(days: 7)).millisecondsSinceEpoch,
        })),
      ];
      arrangeGetCachedTests();
      // act
      final r = await localDataSource.getConversionsHistory();
      // assert
      expect(r, equals(<CurrencyConversionModel>[]));
    },
  );

  test(
    'should cache given conversions',
    () async {
      // arrange
      encodedConversions = [
        jsonEncode(CurrencyConversionModel(
          from: 'f',
          to: 't',
          amount: 1,
          result: null,
        ).toJson()..addAll({
          'created_at': dateTime.millisecondsSinceEpoch,
        })),
      ];
      arrangeGetCachedTests();
      // act
      await localDataSource.cacheCurrencyConversion(conversions.first);
      // assert
      verify(() => mockGetStorage.write(_databaseKey, any()));
    },
  );
}
