import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TelaViagem(),
    );
  }
}

class TelaViagem extends StatefulWidget {
  const TelaViagem({super.key});

  @override
  State<TelaViagem> createState() => _TelaViagemState();
}

class _TelaViagemState extends State<TelaViagem> {
  final distanciaController = TextEditingController();
  final precoController = TextEditingController();
  final consumoController = TextEditingController();
  final velocidadeController = TextEditingController();

  String resultadoCusto = '';
  String resultadoTempo = '';

  void calcularCusto() {
    double distancia =
        double.tryParse(distanciaController.text.replaceAll(',', '.')) ?? 0;

    double preco =
        double.tryParse(precoController.text.replaceAll(',', '.')) ?? 0;

    double consumo =
        double.tryParse(consumoController.text.replaceAll(',', '.')) ?? 0;

    if (distancia > 0 && preco > 0 && consumo > 0) {
      double custo = (distancia / consumo) * preco;

      setState(() {
        resultadoCusto = 'Custo estimado: R\$ ${custo.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        resultadoCusto = 'Digite valores válidos.';
      });
    }
  }

  void calcularTempo() {
    double distancia =
        double.tryParse(distanciaController.text.replaceAll(',', '.')) ?? 0;

    double velocidade =
        double.tryParse(velocidadeController.text.replaceAll(',', '.')) ?? 0;

    if (distancia > 0 && velocidade > 0) {
      double tempo = distancia / velocidade;

      setState(() {
        resultadoTempo = 'Tempo estimado: ${tempo.toStringAsFixed(2)} horas';
      });
    } else {
      setState(() {
        resultadoTempo = 'Digite valores válidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Viagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: distanciaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Distância (km)',
              ),
            ),

            TextField(
              controller: precoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preço do combustível (R\$/L)',
              ),
            ),

            TextField(
              controller: consumoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Consumo do veículo (km/L)',
              ),
            ),

            TextField(
              controller: velocidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Velocidade média (km/h)',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcularCusto,
              child: const Text('Calcular Custo'),
            ),

            Text(resultadoCusto),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcularTempo,
              child: const Text('Calcular Tempo'),
            ),

            Text(resultadoTempo),
          ],
        ),
      ),
    );
  }
}