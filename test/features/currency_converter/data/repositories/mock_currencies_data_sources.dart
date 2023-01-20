import 'package:currency_converter/features/currency_converter/data/data_sources/currencies_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/data_sources/currencies_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrenciesRemoteDataSource extends Mock
    implements CurrenciesRemoteDataSource {}

class MockCurrenciesLocalDataSource extends Mock
    implements CurrenciesLocalDataSource {}
