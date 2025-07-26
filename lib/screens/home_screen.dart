import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_application_1/screens/report_form_screen.dart';
import 'package:flutter_application_1/screens/occurrences_screen.dart'; // Novo import
import 'package:flutter_application_1/widgets/header_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF602368),
      appBar: AppBar(
        backgroundColor: const Color(0xFF602368),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const HeaderImage(height: 40),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Este é o mapa de violência do Instituto Glória',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'O que deseja fazer?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                _buildOptionBox(
                  icon: FontAwesome.hand_paper_o,
                  title: 'QUERO REGISTRAR UMA OCORRÊNCIA',
                  color: const Color(0xFF372482), 
                  borderColor: const Color(0xFF372482), 
                  onTap: () => _navigateToRegister(context),
                ),
                _buildOptionBox(
                  icon: FontAwesome.map_marker,
                  title: 'QUERO VISUALIZAR O MAPA',
                  color: const Color(0xFF612368), 
                  borderColor: const Color(0xFF612368), 
                  onTap: () => _navigateTo(context, '/map'),
                ),
                _buildOptionBox(
                  icon: FontAwesome.pencil,
                  title: 'QUERO SABER MAIS',
                  color: const Color(0xFFBC88BC), 
                  borderColor: const Color(0xFFBC88BC), 
                  onTap: () => _navigateTo(context, '/info'),
                ),
                _buildOptionBox(
                  icon: Icons.gpp_maybe_outlined, 
                  title: 'PRECISO DE AJUDA',
                  color: const Color(0xFFFD0000), 
                  borderColor: const Color(0xFFFD0000), 
                  onTap: () => _navigateTo(context, '/emergency'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionBox({
    required IconData icon,
    required String title,
    Color color = const Color(0xFF602368),
    Color borderColor = Colors.grey,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2.0),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    if (route == '/map') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OccurrencesScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navegar para: $route')),
      );
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReportFormScreen()),
    );
  }
}