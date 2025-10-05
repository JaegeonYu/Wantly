import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// 카테고리 모델
@freezed
@HiveType(typeId: 0)
class Category with _$Category {
  const factory Category({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required int iconCode,
    @HiveField(3) required int colorValue,
    @HiveField(4) @Default(0) int orderIndex,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

/// Category 확장 메서드
extension CategoryExtension on Category {
  /// IconData 가져오기
  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');

  /// Color 가져오기
  Color get color => Color(colorValue);
}
