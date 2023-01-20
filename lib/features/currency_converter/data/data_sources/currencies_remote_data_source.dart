import 'dart:async';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network_utils/network_utils.dart';
import '../models/currency_model.dart';

abstract class CurrenciesRemoteDataSource {
  Future<List<CurrencyModel>> getCurrencies();
}

class CurrenciesRemoteDataSourceImpl implements CurrenciesRemoteDataSource {
  final NetworkUtils networkUtils;

  CurrenciesRemoteDataSourceImpl({required this.networkUtils});

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    final url = 'https://restcountries.com/v3.1/all';
    final response = await networkUtils.get(url);
    if (response.statusCode == 200) {
      List<CurrencyModel> currencies = [];
      for (var i in response.data) {
        currencies.add(CurrencyModel.fromJson(i));
      }
      return currencies;
    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}
