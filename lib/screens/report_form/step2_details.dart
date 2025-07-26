import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/report_model.dart';

class Step2Details extends StatefulWidget {
  final Function(Report) onNext;
  final Function onPrev;
  final Report report;

  const Step2Details({
    super.key,
    required this.onNext,
    required this.onPrev,
    required this.report,
  });

  @override
  State<Step2Details> createState() => _Step2DetailsState();
}

class _Step2DetailsState extends State<Step2Details> {
  final List<String> horarios = List.generate(24, (index) => '$index:00');
  final List<String> faixasEtarias = [
    'Menor de 18 anos',
    '18 a 24 anos',
    '25 a 34 anos',
    '35 a 44 anos',
    '45 a 54 anos',
    '55 a 64 anos',
    '65 anos ou mais'
  ];

  final _formKey = GlobalKey<FormState>();
  late Report _currentReport;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _currentReport = widget.report;
    _dateController = TextEditingController(
      text: "${_currentReport.data.day}/${_currentReport.data.month}/${_currentReport.data.year}"
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF602368),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sinta-se a vontade para compartilhar conosco algumas informações sobre a violência que você enfrentou.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        '2. Que dia ocorreu a violência?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Selecione a data',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: const Icon(Icons.star, color: Colors.red, size: 10),
                        ),
                        validator: (value) {
                          return null;
                        },
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _currentReport.data,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _currentReport = _currentReport.copyWith(data: picked);
                              _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                            });
                          }
                        },
                        controller: _dateController,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '3. Qual foi o horário do ocorrido?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _currentReport.horario.isNotEmpty ? _currentReport.horario : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(Icons.star, color: Colors.red, size: 10),
                        ),
                        items: horarios.map((String horario) {
                          return DropdownMenuItem<String>(
                            value: horario,
                            child: Text(horario),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, selecione um horário';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _currentReport = _currentReport.copyWith(horario: value);
                            });
                          }
                        },
                        hint: const Text('Selecione um horário'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '4. Qual a sua faixa etária?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _currentReport.faixaEtaria.isNotEmpty ? _currentReport.faixaEtaria : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(Icons.star, color: Colors.red, size: 10),
                        ),
                        items: faixasEtarias.map((String faixa) {
                          return DropdownMenuItem<String>(
                            value: faixa,
                            child: Text(faixa),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, selecione uma faixa etária';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _currentReport = _currentReport.copyWith(faixaEtaria: value);
                            });
                          }
                        },
                        hint: const Text('Selecione sua faixa etária'),
                      ),
                      const Spacer(),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onNext(_currentReport);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFEC803),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Próximo'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}