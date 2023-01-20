import 'dart:io';

import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/features/currency_converter/data/data_sources/currency_converter_remote_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_conversion_model.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_conversion.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core_mocks/mock_network_utils.dart';

void main() {
  late CurrencyConverterRemoteDataSourceImpl remoteDataSource;
  late MockNetworkUtils mockNetworkUtils;

  setUp(() {
    mockNetworkUtils = MockNetworkUtils();
    remoteDataSource = CurrencyConverterRemoteDataSourceImpl(
      networkUtils: mockNetworkUtils,
    );
  });

  final conversion = CurrencyConversion(
    from: 'from',
    to: 'to',
    amount: 1,
    result: null,
  );

  final conversionModel = CurrencyConversionModel(
    from: 'from',
    to: 'to',
    amount: 1,
    result: 2,
  );

  final successResponse = Response(
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
    data: {
      'result': 2,
      'query': {
        'amount': 1,
        'to': 'to',
        'from': 'from',
      },
    },
  );

  final quoteExpiredResponse = Response(
    statusCode: 429,
    requestOptions: RequestOptions(path: ''),
  );

  test(
    'should get conversion successfully',
    () async {
      // arrange
      when(() => mockNetworkUtils.get(any(), headers: any(named: "headers")))
          .thenAnswer((_) async => successResponse);
      // act
      final r = await remoteDataSource.convertCurrency(conversion);
      // assert
      expect(r, equals(conversionModel));
    },
  );

  test(
    'should throws server exception when quote expired',
    () async {
      // arrange
      when(() => mockNetworkUtils.get(any(), headers: any(named: "headers")))
          .thenAnswer((_) async => quoteExpiredResponse);
      // act
      final r = remoteDataSource.convertCurrency;
      // assert
      expect(() => r(conversion), throwsA(TypeMatcher<ServerException>()));
    },
  );
}
