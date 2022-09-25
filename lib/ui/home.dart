import 'package:flutter/material.dart';
import 'result.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //definindo campos do form
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _texto = "";
  void _resetCampos() {
    _formkey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _texto = "";
    });
  }

  void _calcular() {
    setState(
      () {
        String _texto = "";
        String _imagem = "";

        double peso = double.parse(pesoController.text);
        double altura = double.parse(alturaController.text);

        double imc = peso / (altura * altura);
        String imcPrecisionFour = imc.toStringAsPrecision(4);

        if (imc < 18.6) {
          _texto = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
          _imagem = "imagens/thin.png";
        } else if (imc >= 18.6 && imc < 24.9) {
          _texto = "Peso ideal (${imc.toStringAsPrecision(4)})";
          _imagem = "imagens/shape.png";
        } else if (imc >= 24.9 && imc < 29.9) {
          _texto = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
          _imagem = "imagens/fat.png";
        } else if (imc >= 29.9 && imc < 34.9) {
          _texto = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
          _imagem = "imagens/fat.png";
        } else if (imc >= 34.9 && imc < 39.9) {
          _texto = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
          _imagem = "imagens/fat.png";
        } else if (imc >= 40) {
          _texto = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
          _imagem = "imagens/fat.png";
        }

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Result(_imagem, _texto)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _resetCampos, icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira seu peso!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira sua altura!";
                    else
                      return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ButtonTheme(
                    height: 50,
                    highlightColor: Colors.amber,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) _calcular();
                      },
                      child: const Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  _texto,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            )),
      ),
    );
  }
}
