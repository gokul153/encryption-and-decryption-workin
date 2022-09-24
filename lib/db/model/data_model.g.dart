// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class messagemodelAdapter extends TypeAdapter<messagemodel> {
  @override
  final int typeId = 1;

  @override
  messagemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return messagemodel(
      message: fields[0] as String,
      hint: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, messagemodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.hint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is messagemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
