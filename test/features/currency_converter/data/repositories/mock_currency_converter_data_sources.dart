import 'package:currency_converter/features/currency_converter/data/data_sources/currency_converter_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/data_sources/currency_converter_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRemoteDataSource extends Mock
    implements CurrencyConverterRemoteDataSource {}

class MockCurrencyConverterLocalDataSource extends Mock
    implements CurrencyConverterLocalDataSource {}
