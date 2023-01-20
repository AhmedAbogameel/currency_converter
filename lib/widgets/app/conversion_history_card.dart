import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../features/currency_converter/domain/entities/currency_conversion.dart';

class ConversionHistoryCard extends StatelessWidget {
  const ConversionHistoryCard({
    Key? key,
    required this.currencyConversion,
  }) : super(key: key);

  final CurrencyConversion currencyConversion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('From : ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${currencyConversion.amount} ( ${currencyConversion.from} )'),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('To : ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${currencyConversion.result} ( ${currencyConversion.to} )'),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGreyColor),
      ),
    );
  }
}
