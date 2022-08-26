import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String infoText = "Insira os dados";
  String? errorTextH;
  String? errorTextW;
  Color color = Colors.black;

  void resetFields() {
    setState(() {
      infoText = "Insira os dados";
      color = Colors.black;
    });
    weightController.text = "";
    heightController.text = "";
    errorTextW = null;
    errorTextH = null;
  }

  void calculate() {
    setState(() {
      if (weightController.text.isEmpty && heightController.text.isEmpty) {
        infoText = "ERRO";
        color = Colors.red;
        errorTextH = "Nenhum dado inserido";
        errorTextW = "Nenhum dado inserido";
        return;
      } else if (weightController.text.isEmpty) {
        infoText = "ERRO";
        color = Colors.red;
        errorTextW = "Peso não inserido";
        errorTextH = null;
        return;
      } else if (heightController.text.isEmpty) {
        infoText = "ERRO";
        color = Colors.red;
        errorTextH = "Altura não inserido";
        errorTextW = null;
        return;
      } else {
        double weight = double.parse(weightController.text);
        double height = double.parse(heightController.text) / 100;
        double imc = weight / (height * height);
        if (imc < 18.6) {
          infoText = "Abaixo do peso\nIMC = ${imc.toStringAsPrecision(3)}";
          color = Colors.blue;
        } else if (imc >= 18.6 && imc < 24.9) {
          infoText = "Peso ideal\nIMC = ${imc.toStringAsPrecision(3)}";
          color = Colors.green;
        } else if (imc >= 24.9 && imc < 29.9) {
          infoText =
              "Levemente acima do peso\nIMC = ${imc.toStringAsPrecision(3)}";
          color = Colors.lightGreen;
        } else if (imc >= 29.9 && imc < 34.9) {
          infoText = "Obesidade Grau I\nIMC = ${imc.toStringAsPrecision(3)}";
          color = Colors.yellow;
        } else if (imc >= 34.9 && imc < 39.9) {
          infoText = "Obesidade Grau II\nIMC = ${imc.toStringAsPrecision(3)}";
          color = Colors.orange;
        } else if (imc >= 40) {
          infoText = "Obesidade Grau III\nIMC = ${imc.toStringAsPrecision(3)}";
          color = Colors.red;
        }
        errorTextW = null;
        errorTextH = null;
        weightController.clear();
        heightController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                resetFields();
              },
              icon: const Icon(
                Icons.refresh_rounded,
              ))
        ],
        title: Column(children: const [
          Text(
            "Calculadora de IMC",
            textAlign: TextAlign.center,
          ),
          Text(
            '(Índice de Massa Corporal)',
            textAlign: TextAlign.center,
          )
        ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(Icons.calculate_rounded, size: 150),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: width * 0.4,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)", errorText: errorTextH),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),
                controller: heightController,
              ),
            ),
            SizedBox(
              width: width * 0.4,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)", errorText: errorTextW),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),
                controller: weightController,
              ),
            ),
          ]),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(25)),
              onPressed: () {
                calculate();
              },
              child: const Text(
                'Calcular',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          Text(
            infoText,
            style: TextStyle(
                fontSize: 30, color: color, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
