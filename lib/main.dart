
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String pantalla = '0';
  double primerNumero = 0;
  String operacion = '';
  bool nuevoNumero = true;

  void presionar(String valor) {
    setState(() {
      if (valor == 'C') {
        pantalla = '0';
        primerNumero = 0;
        operacion = '';
        nuevoNumero = true;
      } else if (valor == '+' ||
          valor == '-' ||
          valor == '×' ||
          valor == '÷') {
        primerNumero = double.tryParse(pantalla) ?? 0;
        operacion = valor;
        nuevoNumero = true;
      } else if (valor == '=') {
        double segundoNumero = double.tryParse(pantalla) ?? 0;
        double resultado = 0;

        switch (operacion) {
          case '+':
            resultado = primerNumero + segundoNumero;
            break;
          case '-':
            resultado = primerNumero - segundoNumero;
            break;
          case '×':
            resultado = primerNumero * segundoNumero;
            break;
          case '÷':
            if (segundoNumero == 0) {
              pantalla = 'Error';
              operacion = '';
              nuevoNumero = true;
              return;
            }
            resultado = primerNumero / segundoNumero;
            break;
        }

        pantalla = resultado % 1 == 0
            ? resultado.toInt().toString()
            : resultado.toString();

        operacion = '';
        nuevoNumero = true;
      } else {
        if (valor == '.' && pantalla.contains('.') && !nuevoNumero) {
          return;
        }

        if (nuevoNumero || pantalla == '0' || pantalla == 'Error') {
          pantalla = valor == '.' ? '0.' : valor;
          nuevoNumero = false;
        } else {
          pantalla += valor;
        }
      }
    });
  }

  Widget boton(String texto) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => presionar(texto),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            child: Text(
              pantalla,
              style: const TextStyle(fontSize: 40),
            ),
          ),
          const Spacer(),
          Row(children: [
            boton('7'),
            boton('8'),
            boton('9'),
            boton('÷'),
          ]),
          Row(children: [
            boton('4'),
            boton('5'),
            boton('6'),
            boton('×'),
          ]),
          Row(children: [
            boton('1'),
            boton('2'),
            boton('3'),
            boton('-'),
          ]),
          Row(children: [
            boton('C'),
            boton('0'),
            boton('.'),
            boton('+'),
          ]),
          Row(children: [
            boton('='),
          ]),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
