// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnedItemAdapter extends TypeAdapter<OwnedItem> {
  @override
  final int typeId = 2;

  @override
  OwnedItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OwnedItem(
      id: fields[0] as String,
      name: fields[1] as String,
      actualPrice: fields[2] as int,
      expectedPrice: fields[3] as int?,
      imageUrl: fields[4] as String?,
      categoryId: fields[5] as String,
      purchaseDate: fields[6] as DateTime,
      satisfactionScore: fields[7] as double,
      satisfactionRank: fields[8] as int,
      review: fields[9] as String,
      wouldBuyAgain: fields[10] as bool,
      tags: (fields[11] as List).cast<String>(),
      createdAt: fields[12] as DateTime?,
      memo: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OwnedItem obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.actualPrice)
      ..writeByte(3)
      ..write(obj.expectedPrice)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.purchaseDate)
      ..writeByte(7)
      ..write(obj.satisfactionScore)
      ..writeByte(8)
      ..write(obj.satisfactionRank)
      ..writeByte(9)
      ..write(obj.review)
      ..writeByte(10)
      ..write(obj.wouldBuyAgain)
      ..writeByte(11)
      ..write(obj.tags)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.memo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnedItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OwnedItemImpl _$$OwnedItemImplFromJson(Map<String, dynamic> json) =>
    _$OwnedItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      actualPrice: (json['actualPrice'] as num).toInt(),
      expectedPrice: (json['expectedPrice'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      categoryId: json['categoryId'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      satisfactionScore: (json['satisfactionScore'] as num?)?.toDouble() ?? 3.0,
      satisfactionRank: (json['satisfactionRank'] as num?)?.toInt() ?? 0,
      review: json['review'] as String? ?? '',
      wouldBuyAgain: json['wouldBuyAgain'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      memo: json['memo'] as String? ?? '',
    );

Map<String, dynamic> _$$OwnedItemImplToJson(_$OwnedItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'actualPrice': instance.actualPrice,
      'expectedPrice': instance.expectedPrice,
      'imageUrl': instance.imageUrl,
      'categoryId': instance.categoryId,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'satisfactionScore': instance.satisfactionScore,
      'satisfactionRank': instance.satisfactionRank,
      'review': instance.review,
      'wouldBuyAgain': instance.wouldBuyAgain,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'memo': instance.memo,
    };
