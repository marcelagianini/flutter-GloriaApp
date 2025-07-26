import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/report_model.dart';

class Step4Consent extends StatefulWidget {
  final Report report;
  final Function() onComplete;
  final Function onPrev;
  final bool isSaving; // Recebe a flag do ReportFormScreen

  const Step4Consent({
    super.key,
    required this.report,
    required this.onComplete,
    required this.onPrev,
    required this.isSaving,
  });

  @override
  State<Step4Consent> createState() => _Step4ConsentState();
}

class _Step4ConsentState extends State<Step4Consent> {
  late Report _currentReport;

  @override
  void initState() {
    super.initState();
    _currentReport = widget.report;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirmação',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Você concorda em enviar essas informações para ajudar no mapeamento da violência contra mulheres?',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      '6. Confirme seu consentimento:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<bool>(
                      value: _currentReport.consentimento,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: const [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: Text('Sim, concordo em enviar'),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: Text('Não, não concordo'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _currentReport = _currentReport.copyWith(consentimento: value);
                          });
                        }
                      },
                    ),
                    const Spacer(),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: widget.isSaving ? null : _submitReport, // Desabilita se estiver salvando
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.isSaving ? Colors.grey : const Color(0xFFFEC803), // Muda a cor se estiver desabilitado
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: widget.isSaving
                            ? const CircularProgressIndicator() // Mostra um indicador de progresso
                            : const Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReport() {
    if (_currentReport.consentimento == true) {
      widget.onComplete(); // Chama a função de conclusão apenas uma vez
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('É necessário consentimento para enviar o relatório')),
      );
    }
  }
}