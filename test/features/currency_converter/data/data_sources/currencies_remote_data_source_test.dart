import 'package:currency_converter/features/currency_converter/data/data_sources/currencies_remote_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core_mocks/mock_network_utils.dart';

void main() {
  late CurrenciesRemoteDataSourceImpl remoteDataSource;
  late MockNetworkUtils networkUtils;

  final successResponse = Response(
    statusCode: 200,
    data: [
      {
        'name': {'official': 'n1'},
        'flags': {'png': 'i1'},
        'currencies': {'c1': ''},
      }
    ],
    requestOptions: RequestOptions(path: ''),
  );

  final unexpectedResponse = Response(
    statusCode: 200,
    data: {
      'name': {'official': 'n1'},
      'flags': {'png': 'i1'},
      'currencies': {'c1': ''},
    },
    requestOptions: RequestOptions(path: ''),
  );

  List<CurrencyModel> currencies = [
    CurrencyModel(
      countryFlag: 'i1',
      currencyCode: 'c1',
      countryName: 'n1'
    ),
  ];

  setUp(() {
    networkUtils = MockNetworkUtils();
    remoteDataSource = CurrenciesRemoteDataSourceImpl(
      networkUtils: networkUtils,
    );
  });

  test(
    'should get list of currencies when successful',
    () async {
      // arrange
      when(() => networkUtils.get(any()))
          .thenAnswer((_) async => successResponse);
      // act
      final r = await remoteDataSource.getCurrencies();
      // assert
      expect(r, equals(currencies));
    },
  );

  test(
    'should throws a cast exception when data is not as expected',
    () async {
      // arrange
      when(() => networkUtils.get(any()))
          .thenAnswer((_) async => unexpectedResponse);
      // act
      final r = remoteDataSource.getCurrencies;
      // assert
      expect(() => r(), throwsA(TypeMatcher<TypeError>()));
    },
  );
}
