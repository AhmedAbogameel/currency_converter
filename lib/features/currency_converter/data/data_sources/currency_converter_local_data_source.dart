import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/currency_conversion_model.dart';

abstract class CurrencyConverterLocalDataSource {
  Future<void> cacheCurrencyConversion(CurrencyConversionModel conversionModel);

  Future<List<CurrencyConversionModel>> getConversionsHistory();
}

class CurrencyConverterLocalDataSourceImpl implements CurrencyConverterLocalDataSource {

  final GetStorage getStorage;

  CurrencyConverterLocalDataSourceImpl({required this.getStorage});

  final _databaseKey = 'conversionHistory';

  @override
  Future<void> cacheCurrencyConversion(CurrencyConversionModel conversionModel) async {
    List conversions = getStorage.hasData(_databaseKey) ? getStorage.read(_databaseKey) as List : [];
    final conversion = conversionModel.toJson();
    conversion.addAll({'created_at': DateTime.now().millisecondsSinceEpoch});
    conversions.insert(0, json.encode(conversion));
    getStorage.write(_databaseKey, conversions);
  }

  @override
  Future<List<CurrencyConversionModel>> getConversionsHistory() async {
    if (!getStorage.hasData(_databaseKey)) {
      return [];
    }
    List conversions = getStorage.read(_databaseKey) as List;
    List<CurrencyConversionModel> currencyConversions = [];
    for (int i = 0; i < conversions.length; i++) {
      final e = json.decode(conversions[i]);
      if (DateTime.fromMillisecondsSinceEpoch(e['created_at']).add(Duration(days: 7)).isAfter(DateTime.now())) {
        currencyConversions.add(CurrencyConversionModel.fromJson(e));
      } else {
        conversions.remove(e);
      }
    }
    _cacheOverrideCachedConversions(conversions);
    return currencyConversions;
  }

  Future<void> _cacheOverrideCachedConversions(List<dynamic> conversions) async {
    await getStorage.write(_databaseKey, conversions);
  }

}