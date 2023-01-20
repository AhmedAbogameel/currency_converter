import 'package:get_it/get_it.dart';

import 'data/data_sources/favourite_currencies_local_data_source.dart';
import 'data/repositories/favourite_currencies_repository_impl.dart';
import 'domain/repositories/favourite_currencies_repository.dart';
import 'domain/use_cases/cache_favourite_currencies.dart';
import 'domain/use_cases/get_favourite_currencies.dart';

Future<void> initSettingsInjector() async {
  final i = GetIt.I;

  i.registerLazySingleton<FavouriteCurrenciesLocalDataSource>(
      () => FavouriteCurrenciesLocalDataSourceImpl(
            getStorage: i(),
          ));

  i.registerLazySingleton<FavouriteCurrenciesRepository>(
      () => FavouriteCurrenciesRepositoryImpl(
            localDataSource: i(),
          ));

  i.registerLazySingleton<CacheFavouriteCurrencies>(
      () => CacheFavouriteCurrencies(repository: i()));

  i.registerLazySingleton<GetFavouriteCurrencies>(
      () => GetFavouriteCurrencies(repository: i()));
}
