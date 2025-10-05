import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_item.freezed.dart';
part 'wishlist_item.g.dart';

/// 위시리스트 아이템 모델
@freezed
@HiveType(typeId: 1)
class WishlistItem with _$WishlistItem {
  const factory WishlistItem({
    /// 고유 ID
    @HiveField(0) required String id,
    
    /// 물품명
    @HiveField(1) required String name,
    
    /// 예상 가격 (원 단위)
    @HiveField(2) required int price,
    
    /// 이미지 경로 (로컬 저장소)
    @HiveField(3) String? imageUrl,
    
    /// 사고 싶은 이유
    @HiveField(4) @Default('') String reason,
    
    /// 카테고리 ID
    @HiveField(5) required String categoryId,
    
    /// 우선순위 (숫자가 작을수록 높음)
    @HiveField(6) @Default(0) int priority,
    
    /// 생성 날짜
    @HiveField(7) required DateTime createdAt,
    
    /// 수정 날짜
    @HiveField(8) DateTime? updatedAt,
    
    /// 태그 목록
    @HiveField(9) @Default([]) List<String> tags,
    
    /// 메모 (추가 정보)
    @HiveField(10) @Default('') String memo,
  }) = _WishlistItem;

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemFromJson(json);
}

/// WishlistItem 확장 메서드
extension WishlistItemExtension on WishlistItem {
  /// 가격 포맷팅 (예: ₩1,200,000)
  String get formattedPrice {
    return '₩${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  /// 등록 후 경과 일수
  int get daysAgo {
    return DateTime.now().difference(createdAt).inDays;
  }

  /// 이미지가 있는지 확인
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
}
