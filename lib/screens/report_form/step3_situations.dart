import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/report_model.dart';

class Step3Situations extends StatefulWidget {
  final Function(Report) onNext;
  final Function onPrev;
  final Report report;

  const Step3Situations({
    super.key,
    required this.onNext,
    required this.onPrev,
    required this.report,
  });

  @override
  State<Step3Situations> createState() => _Step3SituationsState();
}

class _Step3SituationsState extends State<Step3Situations> {
  final List<String> situacoes = [
    'Lesões ou ferimentos (1)',
    'Estrangulamento ou sufocamento (2)',
    'Espancamento ou tortura (3)',
    'Constrangimento ou humilhação (4)',
    'Vigilancia ou perseguição (5)',
    'Proibições ou limitações (6)',
    'Chantagem ou distorção dos fatos (7)',
    'Estupro (8)',
    'Impedimento do uso de contraceptivo (9)',
    'Obrigar atos sexuais que causam desconforto (10)'
  ];

  late Report _currentReport;
  final _formKey = GlobalKey<FormState>();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _currentReport = widget.report;
  }

  void _validateSelection() {
    setState(() {
      _hasError = _currentReport.situacoes.isEmpty;
    });
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
                        'Que situações você vivenciou durante o episódio de violência? Estamos aqui para compreender de forma gentil e acolhedora.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '5. Selecione situações que você identificou durante o episódio:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '* Selecione pelo menos uma opção',
                        style: TextStyle(
                          fontSize: 14,
                          color: _hasError ? Colors.red : Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_hasError)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Por favor, selecione pelo menos uma situação',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: situacoes.length,
                          itemBuilder: (context, index) {
                            final situacao = situacoes[index];
                            return CheckboxListTile(
                              title: Text(situacao),
                              value: _currentReport.situacoes.contains(situacao),
                              onChanged: (bool? value) {
                                setState(() {
                                  final newSituacoes = List<String>.from(_currentReport.situacoes);
                                  if (value == true) {
                                    newSituacoes.add(situacao);
                                  } else {
                                    newSituacoes.remove(situacao);
                                  }
                                  _currentReport = _currentReport.copyWith(situacoes: newSituacoes);
                                  _validateSelection();
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _validateSelection();
                            if (_currentReport.situacoes.isNotEmpty) {
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