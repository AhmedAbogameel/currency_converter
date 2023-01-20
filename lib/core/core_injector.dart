import 'package:currency_converter/core/network_utils/dio_utils.dart';
import 'package:currency_converter/core/network_utils/network_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../features/currency_converter/injector.dart';
import '../features/settings/injector.dart';

Future<void> initCoreInjector() async {
  final i = GetIt.instance;
  i.registerLazySingleton<NetworkUtils>(() => DioUtils());
  final getStorage = GetStorage();
  await getStorage.initStorage;
  i.registerLazySingleton<GetStorage>(() => getStorage);

  await initCurrencyConverterInjector();
  await initSettingsInjector();
}