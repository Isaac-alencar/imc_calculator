import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Imc Calculator App',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() => _infoText = 'Informe seus dados');
  }

  void calcIMC() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = "Abaixo do Peso. Seu IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _infoText = "Peso Ideal. Seu IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 25.0 && imc <= 29.9) {
        _infoText = "Acima do peso. Seu IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 30.0 && imc <= 39.9) {
        _infoText = "Obesidade. Seu IMC = ${imc.toStringAsPrecision(3)}";
      } else {
        _infoText = "Obesidade grave. Seu IMC = ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Imc calculator'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
                onPressed: () => _resetFields())
          ]),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.perm_identity,
                  size: 100.0,
                  color: Colors.green,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Peso(kg)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.0,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira a sua altura!";
                    }
                  },
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: 'Altura(m)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () => {
                        if (_formKey.currentState.validate()) {calcIMC()}
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 24.0),
                ),
              ],
            ),
          )),
    );
  }
}
