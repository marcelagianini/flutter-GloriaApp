// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 0;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Report(
      estado: fields[0] as String,
      data: fields[1] as DateTime,
      horario: fields[2] as String,
      faixaEtaria: fields[3] as String,
      situacoes: (fields[4] as List).cast<String>(),
      consentimento: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.estado)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.horario)
      ..writeByte(3)
      ..write(obj.faixaEtaria)
      ..writeByte(4)
      ..write(obj.situacoes)
      ..writeByte(5)
      ..write(obj.consentimento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
