import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/snack_bar.dart';
import '../../../../settings/domain/use_cases/get_favourite_currencies.dart';
import '../../../domain/entities/currency.dart';
import '../../../domain/entities/currency_conversion.dart';
import '../../../domain/use_cases/cache_conversion_history.dart';
import '../../../domain/use_cases/convert_currency.dart';
import '../../../domain/use_cases/get_conversions_history.dart';

part 'states.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterStates> {
  CurrencyConverterCubit({
    required this.convertCurrency,
    required this.getConversionsHistoryUC,
    required this.getFavouriteCurrencies,
    required this.cacheConversionHistory,
  }) : super(CurrencyConverterInit());

  static CurrencyConverterCubit of(context) => BlocProvider.of(context);

  final ConvertCurrency convertCurrency;
  final GetConversionsHistory getConversionsHistoryUC;
  final GetFavouriteCurrencies getFavouriteCurrencies;
  final CacheConversionHistory cacheConversionHistory;

  List<CurrencyConversion> conversionsHistory = [];

  Currency? from;
  Currency? to;
  TextEditingController amountController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  Future<void> init() async {
    getConversionsHistory();
    amountController.addListener(() {
      resultController.clear();
      emit(CurrencyConverterInit());
    });
  }

  Future<void> convert() async {
    if (!areInputsValid) {
      return;
    }
    emit(CurrencyConverterLoading());
    final currencyConversion = CurrencyConversion(
      from: from!.currencyCode,
      to: to!.currencyCode,
      amount: num.parse(amountController.text),
      result: null,
    );
    final result = await convertCurrency(currencyConversion);
    result.fold(
      (l) => showAppFailureSnackBar(l),
      (r) async {
        resultController.text = r.result.toString();
        await _onConversionSuccess(r);
      },
    );
    emit(CurrencyConverterInit());
  }

  Future<void> _onConversionSuccess(CurrencyConversion c) async {
    final result = await getFavouriteCurrencies();
    result.fold((l) {}, (right) {
      right.forEach((element) async {
        if (element.currencyCode == from!.currencyCode || element.currencyCode == to!.currencyCode) {
          conversionsHistory.insert(0, c);
          await cacheConversionHistory(c);
        }
      });
    });
  }

  bool get areInputsValid {
    return amountController.text.trim().isNotEmpty &&
        to != null &&
        from != null;
  }

  void selectFrom(Currency value) {
    from = value;
    resultController.clear();
    emit(CurrencyConverterInit());
  }

  void selectTo(Currency value) {
    to = value;
    resultController.clear();
    emit(CurrencyConverterInit());
  }

  Future<void> getConversionsHistory() async {
    final result = await getConversionsHistoryUC();
    result.fold((l) {}, (r) {
      conversionsHistory.addAll(r);
      emit(CurrencyConverterInit());
    });
  }

  @override
  Future<void> close() {
    amountController.dispose();
    resultController.dispose();
    return super.close();
  }
}
