import '../../../../core/errors/exceptions.dart';
import '../../../../core/network_utils/network_utils.dart';
import '../../domain/entities/currency_conversion.dart';
import '../models/currency_conversion_model.dart';

abstract class CurrencyConverterRemoteDataSource {
  Future<CurrencyConversionModel> convertCurrency(
      CurrencyConversion currencyConversion);
}

class CurrencyConverterRemoteDataSourceImpl
    implements CurrencyConverterRemoteDataSource {
  final NetworkUtils networkUtils;

  CurrencyConverterRemoteDataSourceImpl({required this.networkUtils});

  @override
  Future<CurrencyConversionModel> convertCurrency(
      CurrencyConversion currencyConversion) async {
    final response = await networkUtils.get(
      'https://api.apilayer.com/exchangerates_data/convert?to=${currencyConversion.to}&from=${currencyConversion.from}&amount=${currencyConversion.amount}',
      headers: {
        'apikey': 'QDrcTsQKjsY2TVW42wfg5P6dubfaEZQg',
      },
    );
    if (response.statusCode == 200) {
      return CurrencyConversionModel.fromJson(response.data);
    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}
