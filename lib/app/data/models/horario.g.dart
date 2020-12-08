// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HorarioAdapter extends TypeAdapter<Horario> {
  @override
  final int typeId = 4;

  @override
  Horario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Horario(
      start: fields[0] as DateTime,
      duration: fields[1] as Duration,
      agendamento: fields[2] as Agendamento,
      livre: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Horario obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.agendamento)
      ..writeByte(3)
      ..write(obj.livre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
