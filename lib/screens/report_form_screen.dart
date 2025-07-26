import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/models/report_model.dart';
import 'package:flutter_application_1/widgets/header_image.dart';
import 'package:flutter_application_1/screens/report_form/step1_state.dart';
import 'package:flutter_application_1/screens/report_form/step2_details.dart';
import 'package:flutter_application_1/screens/report_form/step3_situations.dart';
import 'package:flutter_application_1/screens/report_form/step4_consent.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  int _currentStep = 0;
  bool _isSaving = false; // Flag para controle de salvamento
  Report _report = Report(
    estado: '',
    data: DateTime.now(),
    horario: '',
    faixaEtaria: '',
    situacoes: [],
    consentimento: null,
  );

  void _nextStep(Report report) {
    setState(() {
      _report = report;
      _currentStep++;
    });
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _completeForm() {
    if (_isSaving) return; // Evita múltiplos cliques

    setState(() {
      _isSaving = true; // Inicia o salvamento
    });

    // Adicione este print para depuração
    print("Salvando relatório no Hive...");
    
    final reportsBox = Hive.box<Report>('reports');
    reportsBox.add(_report); // Isso deve ser chamado apenas UMA vez
    
    // Adicione este print para ver quantos relatórios existem
    print("Total de relatórios após salvar: ${reportsBox.length}");
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF602368),
      appBar: AppBar(
        backgroundColor: const Color(0xFF602368),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFFFEC803),
            ),
          ),
          onPressed: () {
            if (_currentStep == 0) {
              Navigator.pop(context);
            } else {
              _prevStep();
            }
          },
        ),
        centerTitle: true,
        title: const HeaderImage(height: 40),
        actions: _currentStep == 0
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFFFEC803),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ]
            : null,
      ),
      body: _buildCurrentStep(),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return Step1State(onNext: _nextStep, report: _report);
      case 1:
        return Step2Details(onNext: _nextStep, onPrev: _prevStep, report: _report);
      case 2:
        return Step3Situations(onNext: _nextStep, onPrev: _prevStep, report: _report);
      case 3:
        return Step4Consent(
          report: _report,
          onComplete: _completeForm,
          onPrev: _prevStep,
          isSaving: _isSaving, // Passando a flag para o Step4
        );
      default:
        return Step1State(onNext: _nextStep, report: _report);
    }
  }
}