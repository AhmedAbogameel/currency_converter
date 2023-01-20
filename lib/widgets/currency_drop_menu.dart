import 'package:currency_converter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../colors.dart';
import '../features/currency_converter/domain/entities/currency.dart';
import '../features/currency_converter/presentation/converter/countries_cubit/cubit.dart';

class CurrencyDropMenu extends StatefulWidget {
  const CurrencyDropMenu({
    Key? key,
    required this.onChanged,
    required this.hint,
    this.value,
  }) : super(key: key);

  final String hint;
  final Currency? value;
  final Function(Currency) onChanged;

  @override
  State<CurrencyDropMenu> createState() => _CurrencyDropMenuState();
}

class _CurrencyDropMenuState extends State<CurrencyDropMenu> {
  Currency? value;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() => value = widget.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrenciesCubit(
        getCurrenciesUC: context.di(),
      )..getCurrencies(),
      child: BlocBuilder<CurrenciesCubit, CurrenciesStates>(
        builder: (context, state) => DropdownButtonFormField(
          hint: Text(widget.hint),
          value: value,
          isExpanded: true,
          items: context.read<CurrenciesCubit>().currencies.map((e) => DropdownMenuItem<Currency>(
            child: Row(
              children: [
                Image.network(
                  e.countryFlag,
                  height: 32,
                  width: 32,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline),
                ),
                SizedBox(width: 10),
                Expanded(child: Text(e.countryName + " ( ${e.currencyCode} )")),
              ],
            ),
            value: e,
          )).toList(),
          onChanged: (value) {
            this.value = value;
            setState(() {});
            widget.onChanged(value!);
          },
          borderRadius: borderRadius,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16, right: 8),
            border: OutlineInputBorder(borderRadius: borderRadius),
            enabledBorder: getBorder(kGreyColor),
            focusedBorder: getBorder(kGreyColor),
            errorBorder: getBorder(Colors.red),
            focusedErrorBorder: getBorder(kPrimaryColor),
            disabledBorder: getBorder(Colors.transparent),
          ),
        ),
      ),
    );
  }

  final BorderRadius borderRadius = BorderRadius.circular(8);

  InputBorder getBorder(Color color) => OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color),
      );
}
