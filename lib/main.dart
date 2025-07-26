import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/models/report_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa o Hive
  await Hive.initFlutter();
  
  // Registra o adaptador
  Hive.registerAdapter(ReportAdapter());
  
  // Abre a caixa de relatórios
  await Hive.openBox<Report>('reports');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa da Violência - Instituto Glória',
      theme: ThemeData(
        primaryColor: const Color(0xFF602368),
        scaffoldBackgroundColor: const Color(0xFF602368),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}