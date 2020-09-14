import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
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
  final _tPeso = TextEditingController();
  final _tAltura = TextEditingController();
  final _tservico = TextEditingController();
  var _infoText = "Coloque os valores da conta!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Divisor de Contas"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tPeso.text = "";
    _tAltura.text = "";
    _tservico.text = "";
    setState(() {
      _infoText = "Coloque os valores da conta!";
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
              _editText("Conta Total", _tPeso),
              _editText("Numero de pessoas", _tAltura),
              _editText("Taxa de serviço", _tservico),
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
        color: Colors.orange,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
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
        color: Colors.orange,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR A CONTA DO BAR
  void _calculate(){
    setState(() {
      double total = double.parse(_tPeso.text);
      double n_pessoas = double.parse(_tAltura.text) ;
      double taxa =  double.parse(_tservico.text) ;
      double total_geral = (total/n_pessoas)*(1+(taxa/100))   ;
      double total_geral_servico =  total * (taxa/100);
      String total_geral_servicoStr = total_geral_servico.toStringAsPrecision(4);
      String total_geralStr = total_geral.toStringAsPrecision(4);

      _infoText = "Deu R\$ $total_geralStr  para cada pessoa \n A taxa de serviço foi de R\$$total_geral_servicoStr";


    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.orange, fontSize: 25.0),
    );
  }
}
