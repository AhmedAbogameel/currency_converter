import 'package:currency_converter/core/extensions/build_context.dart';
import 'package:currency_converter/features/settings/presentation/currency_history/cubit.dart';
import 'package:currency_converter/widgets/button.dart';
import 'package:currency_converter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/currency_drop_menu.dart';

class CurrencyHistorySettingView extends StatelessWidget {
  const CurrencyHistorySettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyHistorySettingCubit(
        getFavouriteCurrenciesUC: context.di(),
        cacheFavouriteCurrenciesUC: context.di(),
      )..getFavouriteCurrencies(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Currency History Setting'),
        ),
        body: BlocBuilder<CurrencyHistorySettingCubit, CurrencyHistorySettingStates>(
          builder: (context, state) {
            final cubit = CurrencyHistorySettingCubit.of(context);
            final favouriteCurrencies = cubit.favouriteCurrencies;
            if (state is CurrencyHistorySettingLoading) {
              return LoadingIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Choose 2 currencies to cache for 7 days',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  CurrencyDropMenu(
                    hint: "First",
                    onChanged: (v) => cubit.selectFavouriteCurrency(0, v),
                    value: favouriteCurrencies.isEmpty ? null : favouriteCurrencies.first,
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: favouriteCurrencies.isNotEmpty,
                    child: CurrencyDropMenu(
                      hint: "Second",
                      onChanged: (v) => cubit.selectFavouriteCurrency(1, v),
                      value: favouriteCurrencies.length == 2 ? favouriteCurrencies.last : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  Button(
                    title: 'Save',
                    onPressed: cubit.cacheFavouriteCurrencies,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
