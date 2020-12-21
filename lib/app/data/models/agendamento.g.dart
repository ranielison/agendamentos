// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgendamentoAdapter extends TypeAdapter<Agendamento> {
  @override
  final int typeId = 0;

  @override
  Agendamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Agendamento(
      idAgendamento: fields[0] as String,
      cliente: fields[1] as Cliente,
      durationInMinutes: fields[2] as int,
      startDate: fields[3] as DateTime,
      servicos: (fields[4] as List)?.cast<Servico>(),
      isRetorno: fields[5] as bool,
      concluido: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Agendamento obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.idAgendamento)
      ..writeByte(1)
      ..write(obj.cliente)
      ..writeByte(2)
      ..write(obj.durationInMinutes)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.servicos)
      ..writeByte(5)
      ..write(obj.isRetorno)
      ..writeByte(6)
      ..write(obj.concluido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
