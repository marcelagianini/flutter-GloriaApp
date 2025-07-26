import 'package:hive/hive.dart';

part 'report_model.g.dart';

@HiveType(typeId: 0)
class Report {
  @HiveField(0)
  String estado;

  @HiveField(1)
  DateTime data;

  @HiveField(2)
  String horario;

  @HiveField(3)
  String faixaEtaria;

  @HiveField(4)
  List<String> situacoes;

  @HiveField(5)
  bool? consentimento;

  Report({
    this.estado = '',
    required this.data,
    this.horario = '',
    this.faixaEtaria = '',
    this.situacoes = const [],
    this.consentimento,
  });

  // Método para criar cópia atualizada
  Report copyWith({
    String? estado,
    DateTime? data,
    String? horario,
    String? faixaEtaria,
    List<String>? situacoes,
    bool? consentimento,
  }) {
    return Report(
      estado: estado ?? this.estado,
      data: data ?? this.data,
      horario: horario ?? this.horario,
      faixaEtaria: faixaEtaria ?? this.faixaEtaria,
      situacoes: situacoes ?? this.situacoes,
      consentimento: consentimento ?? this.consentimento,
    );
  }
}