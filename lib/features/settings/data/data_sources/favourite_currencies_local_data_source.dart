import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../../currency_converter/data/models/currency_model.dart';

abstract class FavouriteCurrenciesLocalDataSource {
  Future<List<CurrencyModel>> getFavouriteCurrencies();

  Future<void> cacheFavouriteCurrencies({
    required List<CurrencyModel> currencies,
  });
}

class FavouriteCurrenciesLocalDataSourceImpl
    implements FavouriteCurrenciesLocalDataSource {

  final GetStorage getStorage;

  FavouriteCurrenciesLocalDataSourceImpl({required this.getStorage});

  final _favouriteCurrenciesDatabaseKey = 'favouriteCurrencies';

  @override
  Future<void> cacheFavouriteCurrencies({
    required List<CurrencyModel> currencies,
  }) async {
    getStorage.write(_favouriteCurrenciesDatabaseKey, currencies.map((e) => json.encode(e.toJson)).toList());
  }

  @override
  Future<List<CurrencyModel>> getFavouriteCurrencies() async {
    if (getStorage.hasData(_favouriteCurrenciesDatabaseKey)) {
      return (getStorage.read(_favouriteCurrenciesDatabaseKey) as List).map((e) => CurrencyModel.fromJson(json.decode(e))).toList();
    }
    return [];
  }
}
