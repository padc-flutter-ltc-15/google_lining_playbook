// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_links_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyLinkVOAdapter extends TypeAdapter<BuyLinksVO> {
  @override
  final int typeId = 1;

  @override
  BuyLinksVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyLinksVO(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BuyLinksVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyLinkVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyLinksVO _$BuyLinksVOFromJson(Map<String, dynamic> json) => BuyLinksVO(
      json['name'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$BuyLinksVOToJson(BuyLinksVO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
