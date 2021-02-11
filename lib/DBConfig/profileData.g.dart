// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileDataAdapter extends TypeAdapter<ProfileData> {
  @override
  ProfileData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileData(
      name: fields[0] as String,
      imagePath: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imagePath);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
