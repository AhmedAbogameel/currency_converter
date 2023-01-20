import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/currency_model.dart';

abstract class CurrenciesLocalDataSource {
  Future<List<CurrencyModel>?> getCurrencies();
  Future<void> cacheCurrencies(List<CurrencyModel> currencies);
}

class CurrenciesLocalDataSourceImpl implements CurrenciesLocalDataSource {

  final GetStorage getStorage;

  CurrenciesLocalDataSourceImpl({required this.getStorage});

  final _databaseKey = 'currencies';

  @override
  Future<void> cacheCurrencies(List<CurrencyModel> currencies) async {
    List<Map<String, dynamic>> c = currencies.map((e) => e.toJson).toList();
    await getStorage.write(_databaseKey, json.encode(c));
  }

  @override
  Future<List<CurrencyModel>?> getCurrencies() async {
    if (getStorage.hasData(_databaseKey)) {
      final data = await getStorage.read(_databaseKey);
      final decodedData = json.decode(data) as List;
      List<CurrencyModel> currencies = [];
      for (var i in decodedData) {
        currencies.add(CurrencyModel.fromJson(i));
      }
      return currencies;
    }
    return null;
  }

}