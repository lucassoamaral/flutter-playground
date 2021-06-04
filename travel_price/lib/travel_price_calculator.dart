import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TravelPriceCalculatorForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TravelPriceCalculatorFormState();
}

class _TravelPriceCalculatorFormState extends State<TravelPriceCalculatorForm> {
  // Global unique key that allows to validate de form.
  final _formKey = GlobalKey<FormState>();

  // Variables to store the form fields values.
  double? distance, consumption, price;

  @override
  Widget build(BuildContext context) {
    // Builds the travel price calculator form.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _requiredNumericField(
            'Distância (KM)',
            Icons.map, 
            (String? value) {
              distance = double.parse(value!);
            }),
          _requiredNumericField(
            'Consumo (KM/L)', 
            Icons.local_gas_station,
            (String? value) {
              consumption = double.parse(value!);
            }),
          _requiredNumericField(
            'Preço do combustível (R\$)', Icons.monetization_on,
            (String? value) {
              price = double.parse(value!);
            }),
          _submitButton(() {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              String travelPrice =
                  ((distance! / consumption!) * price!).toStringAsFixed(2);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Sua viagem custará R\$ $travelPrice!')));
            }
          })
        ],
      ),
    );
  }

  // Creates a required field forcing the input of only numeric values (including decimals).
  Widget _requiredNumericField(
          String fieldLabel, IconData icon, Function(String?)? onSaved) =>
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: TextFormField(
              decoration:
                  InputDecoration(labelText: '$fieldLabel *', icon: Icon(icon)),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onSaved: onSaved,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Por favor, preencha o campo "$fieldLabel".'
                  : null));

  // Creates a form submit button.
  Widget _submitButton(Function()? onPressed) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(EdgeInsets.all(30))),
          child: Text('Calcular')));
}
