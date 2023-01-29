// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_info_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationInfoHiveDTOAdapter extends TypeAdapter<LocationInfoHiveDTO> {
  @override
  final int typeId = 1;

  @override
  LocationInfoHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationInfoHiveDTO(
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      altitude: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LocationInfoHiveDTO obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.altitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationInfoHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
