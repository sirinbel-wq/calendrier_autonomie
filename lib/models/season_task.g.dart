// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeasonTaskAdapter extends TypeAdapter<SeasonTask> {
  @override
  final int typeId = 2;

  @override
  SeasonTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeasonTask(
      title: fields[0] as String,
      date: fields[1] as DateTime?,
      category: fields[2] as String?,
      completed: fields[3] as bool,
      season: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SeasonTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.season);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
