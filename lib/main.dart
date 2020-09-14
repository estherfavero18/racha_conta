import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racha Conta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primarySwatch: Colors.red,
          primaryColor: Colors.brown[800],
          primaryColorDark: Colors.brown[900],
          cursorColor: Colors.deepOrangeAccent),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VARIAVEIS
  final _vrTotal = TextEditingController();
  final _qtde = TextEditingController();
  final _perGarcom = TextEditingController();
  var _infoText = "";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      body: _body(),
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields() {
    _vrTotal.text = "";
    _qtde.text = "";
    _perGarcom.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor da Conta", _vrTotal),
              _editText("Qtde de pessoas", _qtde),
              _editText("% garçom", _perGarcom),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.deepOrangeAccent,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.deepOrangeAccent,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.deepOrangeAccent,
        child: Text(
          "Calcular",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR O VALOR  PARA CADA PESSOA
  void _calculate() {
    setState(() {
      double total = double.parse(_vrTotal.text);
      double qt = double.parse(_qtde.text);
      double percent = double.parse(_perGarcom.text) / 100;
      double vrParGarcom = total * percent;
      double vrParPessoa = (vrParGarcom + total) / qt;
      String strParPessoa = vrParPessoa.toStringAsPrecision(4);
      String strParGarcom = vrParGarcom.toStringAsPrecision(4);
      _infoText =
          "Valor para garçom: $strParGarcom \n Valor por pessoa: $strParPessoa";
    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
    );
  }
}
