import 'package:get_it/get_it.dart';

import 'data/data_sources/currencies_local_data_source.dart';
import 'data/data_sources/currencies_remote_data_source.dart';
import 'data/data_sources/currency_converter_local_data_source.dart';
import 'data/data_sources/currency_converter_remote_data_source.dart';
import 'data/repositories/currencies_repository_impl.dart';
import 'data/repositories/currency_converter_repository_impl.dart';
import 'domain/repositories/currencies_repository.dart';
import 'domain/repositories/currency_converter_repository.dart';
import 'domain/use_cases/cache_conversion_history.dart';
import 'domain/use_cases/convert_currency.dart';
import 'domain/use_cases/get_conversions_history.dart';
import 'domain/use_cases/get_currencies.dart';

Future<void> initCurrencyConverterInjector() async {
  final i = GetIt.instance;

  i.registerLazySingleton<CurrenciesRemoteDataSource>(
      () => CurrenciesRemoteDataSourceImpl(
            networkUtils: i(),
          ));
  i.registerLazySingleton<CurrenciesLocalDataSource>(
      () => CurrenciesLocalDataSourceImpl(
            getStorage: i(),
          ));

  i.registerLazySingleton<CurrencyConverterRemoteDataSource>(
      () => CurrencyConverterRemoteDataSourceImpl(
            networkUtils: i(),
          ));

  i.registerLazySingleton<CurrencyConverterLocalDataSource>(
      () => CurrencyConverterLocalDataSourceImpl(
            getStorage: i(),
          ));

  i.registerLazySingleton<CurrenciesRepository>(() => CurrenciesRepositoryImpl(
        remoteDataSource: i(),
        localDataSource: i(),
      ));

  i.registerLazySingleton<CurrencyConverterRepository>(
      () => CurrencyConverterRepositoryImpl(
            remoteDataSource: i(),
            localDataSource: i(),
      ));

  i.registerLazySingleton<GetCurrencies>(() => GetCurrencies(i()));
  i.registerLazySingleton<ConvertCurrency>(() => ConvertCurrency(i()));
  i.registerLazySingleton<GetConversionsHistory>(() => GetConversionsHistory(i()));
  i.registerLazySingleton<CacheConversionHistory>(() => CacheConversionHistory(i()));
}
