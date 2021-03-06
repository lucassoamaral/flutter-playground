import 'package:flutter/material.dart';
import 'package:travel_price/travel_price_calculator.dart';

void main() {
  runApp(TravelPriceCalculatorApp());
}

class TravelPriceCalculatorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(title: Text('Calcular custo da viagem')),
        body: TravelPriceCalculatorForm(),
      ),
    );
  }
}
