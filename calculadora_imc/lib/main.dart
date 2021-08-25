import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //tela principal
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //adicionando funcionalidades no app | pegando os valores do peso e da altura
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";

    //atualizando o estado do app
    setState(() {
      _infoText = "Informe seus dados";
    });

    //retira as mensagens de erro ao da refresh no app
    _formKey = GlobalKey<FormState>();

  }

  void _calculate(){
    setState(() {
      //transformando o texto em double
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (IMC: ${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (IMC: ${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.6 && imc < 29.9){
        _infoText = "Levemente acima do peso (IMC: ${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I (IMC: ${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II (IMC: ${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40){
        _infoText = "Obesidade grau III (IMC: ${imc.toStringAsPrecision(4)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    //scaffold facilita as barras superios e inferior com icones
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.pink, //cor de fundo da appBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white, //cor de fundo do app
      //body: corpo do app
      //SingleChildScrollView: rolagem do app, so pode ter um filho
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          //fazendo a validacao dos dados do form
          key: _formKey,
          child: Column(
            //eixo cruzado da coluna eh o horizontal
            //stretch: tenta preencher toda a largura, o icone nao ira preencher porque especificamos um tamanho para ele
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.pink),

              //form
              TextFormField(
                keyboardType:
                TextInputType.number, //tipo que vai ser permitido no campo
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.pink)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink, fontSize: 25.0),
                controller: weightController, //pegando o peso
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType:
                TextInputType.number, //tipo que vai ser permitido no campo
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.pink)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink, fontSize: 25.0),
                controller: heightController, //pegando a altura
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),

              //Padding: para adicionar espaçamento ao redor do botao
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  //Container: para poder mexer na altura, coloca o botao para dentro do container
                  height: 50.0,
                  //raisedButton: botao com cor de fundo
                  child: RaisedButton(
                    onPressed: (){
                      //verificando se formulario eh valido
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.pink,
                  ),
                ),
              ),
              Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.pink, fontSize: 25.0)),
            ],
          ),
        ),
      ),
    );
  }
}
