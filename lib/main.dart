import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'colors.dart';
import 'core/core_injector.dart';
import 'features/currency_converter/presentation/converter/view.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
BuildContext get globalContext => _navigatorKey.currentState!.context;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initCoreInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(kPrimaryColor.value, kPrimarySwatch),
        ).copyWith(
          secondary: Color(0xFFA0C3D2),
        ),
      ),
      builder: (context, child) => SafeArea(
        child: child!,
        top: false,
      ),
      home: CurrencyConverterView(),
    );
  }
}
