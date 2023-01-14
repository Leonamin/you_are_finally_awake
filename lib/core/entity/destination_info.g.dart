// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DestinationInfoAdapter extends TypeAdapter<DestinationInfo> {
  @override
  final int typeId = 0;

  @override
  DestinationInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DestinationInfo(
      id: fields[0] as int,
      title: fields[1] as String,
      location: fields[2] as Location,
      radius: fields[3] as double,
      periodicMinute: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DestinationInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.radius)
      ..writeByte(4)
      ..write(obj.periodicMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DestinationInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
