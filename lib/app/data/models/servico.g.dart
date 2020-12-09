// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servico.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServicoAdapter extends TypeAdapter<Servico> {
  @override
  final int typeId = 5;

  @override
  Servico read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Servico(
      id: fields[0] as int,
      description: fields[1] as String,
      value: fields[2] as double,
      durationInMinutes: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Servico obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.durationInMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
