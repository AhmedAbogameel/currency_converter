import 'package:currency_converter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../colors.dart';
import '../../../../core/router/router.dart';
import '../../../../widgets/app/conversion_history_card.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/currency_drop_menu.dart';
import '../../../../widgets/input_form_field.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../settings/presentation/currency_history/view.dart';
import 'currency_converter_cubit/cubit.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyConverterCubit(
        convertCurrency: context.di(),
        getConversionsHistoryUC: context.di(),
        getFavouriteCurrencies: context.di(),
        cacheConversionHistory: context.di(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Currency Converter"),
          actions: [
            IconButton(
              onPressed: () => pushView(CurrencyHistorySettingView()),
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            final cubit = CurrencyConverterCubit.of(context);
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                CurrencyDropMenu(
                  hint: "From",
                  onChanged: cubit.selectFrom,
                  value: null,
                ),
                SizedBox(height: 10),
                CurrencyDropMenu(
                  hint: "To",
                  onChanged: cubit.selectTo,
                  value: null,
                ),
                SizedBox(height: 10),
                InputFormField(
                  hint: "Amount",
                  textInputType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  controller: cubit.amountController,
                ),
                SizedBox(height: 10),
                InputFormField(
                  readOnly: true,
                  controller: cubit.resultController,
                ),
                SizedBox(height: 20),
                BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) => Visibility(
                    visible: state is CurrencyConverterLoading,
                    child: LoadingIndicator(),
                    replacement: Button(
                      title: "Convert",
                      onPressed: cubit.areInputsValid ? cubit.convert : null,
                    ),
                  ),
                ),
                BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    final conversions = cubit.conversionsHistory;
                    if (conversions.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(color: kGreyColor, height: 50),
                        Text(
                          'Favourite Currencies History',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '( Last 7 days only )',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: conversions.length,
                          itemBuilder: (context, index) => ConversionHistoryCard(
                            currencyConversion: conversions[index],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
