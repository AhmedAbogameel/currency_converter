import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/snack_bar.dart';
import '../../../currency_converter/domain/entities/currency.dart';
import '../../domain/use_cases/cache_favourite_currencies.dart';
import '../../domain/use_cases/get_favourite_currencies.dart';

part 'states.dart';

class CurrencyHistorySettingCubit extends Cubit<CurrencyHistorySettingStates> {
  CurrencyHistorySettingCubit({
    required this.getFavouriteCurrenciesUC,
    required this.cacheFavouriteCurrenciesUC,
  }) : super(CurrencyHistorySettingInit());

  static CurrencyHistorySettingCubit of(context) => BlocProvider.of(context);

  final GetFavouriteCurrencies getFavouriteCurrenciesUC;
  final CacheFavouriteCurrencies cacheFavouriteCurrenciesUC;

  List<Currency> favouriteCurrencies = [];

  Future<void> getFavouriteCurrencies() async {
    emit(CurrencyHistorySettingLoading());
    final result = await getFavouriteCurrenciesUC();
    result.fold((l) {}, (r) => favouriteCurrencies = r);
    emit(CurrencyHistorySettingInit());
  }

  Future<void> cacheFavouriteCurrencies() async {
    if (favouriteCurrencies.isEmpty) {
      return;
    }
    final result = await cacheFavouriteCurrenciesUC(
      currencies: favouriteCurrencies,
    );
    result.fold(
      (l) => showSnackBar("Error!", isError: true),
      (r) => showSnackBar("Saved!"),
    );
  }

  void selectFavouriteCurrency(int index, Currency currency) {
    if (favouriteCurrencies.length == 2 || favouriteCurrencies.length - 1 == index) {
      favouriteCurrencies[index] = currency;
    } else {
      favouriteCurrencies.add(currency);
    }
    emit(CurrencyHistorySettingInit());
  }

}
