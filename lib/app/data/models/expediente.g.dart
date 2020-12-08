// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expediente.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpedienteDayAdapter extends TypeAdapter<ExpedienteDay> {
  @override
  final int typeId = 2;

  @override
  ExpedienteDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpedienteDay(
      inicio: (fields[0] as List)?.cast<int>(),
      pausa: (fields[1] as List)?.cast<int>(),
      retorno: (fields[2] as List)?.cast<int>(),
      fim: (fields[3] as List)?.cast<int>(),
      aberto: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExpedienteDay obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.inicio)
      ..writeByte(1)
      ..write(obj.pausa)
      ..writeByte(2)
      ..write(obj.retorno)
      ..writeByte(3)
      ..write(obj.fim)
      ..writeByte(4)
      ..write(obj.aberto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpedienteDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
