// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expediente_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpedienteSettingsAdapter extends TypeAdapter<ExpedienteSettings> {
  @override
  final int typeId = 3;

  @override
  ExpedienteSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpedienteSettings(
      intervalo: fields[0] as Duration,
      expedientes: (fields[1] as List)?.cast<ExpedienteDay>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpedienteSettings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.intervalo)
      ..writeByte(1)
      ..write(obj.expedientes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpedienteSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
