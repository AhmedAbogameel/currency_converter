import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/currency.dart';
import '../../../domain/use_cases/get_currencies.dart';

part 'states.dart';

class CurrenciesCubit extends Cubit<CurrenciesStates> {
  CurrenciesCubit({required this.getCurrenciesUC}) : super(CurrenciesInit());

  static CurrenciesCubit of(context) => BlocProvider.of(context);

  final GetCurrencies getCurrenciesUC;
  List<Currency> currencies = [];

  Future<void> getCurrencies() async {
    emit(CurrenciesLoading());
    final result = await getCurrenciesUC();
    result.fold((l) {}, (r) {
      currencies = r;
    });
    emit(CurrenciesInit());
  }

}