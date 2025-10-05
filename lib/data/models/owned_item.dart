import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'owned_item.freezed.dart';
part 'owned_item.g.dart';

/// 구매 완료 아이템 모델
@freezed
@HiveType(typeId: 2)
class OwnedItem with _$OwnedItem {
  const factory OwnedItem({
    /// 고유 ID
    @HiveField(0) required String id,

    /// 물품명
    @HiveField(1) required String name,

    /// 실제 구매 가격 (원 단위)
    @HiveField(2) required int actualPrice,

    /// 예상 가격 (위시리스트에 있을 때)
    @HiveField(3) int? expectedPrice,

    /// 이미지 경로 (로컬 저장소)
    @HiveField(4) String? imageUrl,

    /// 카테고리 ID
    @HiveField(5) required String categoryId,

    /// 구매 날짜
    @HiveField(6) required DateTime purchaseDate,

    /// 만족도 점수 (1.0 ~ 5.0)
    @HiveField(7) @Default(3.0) double satisfactionScore,

    /// 만족도 순위 (드래그앤드롭용, 숫자가 작을수록 높음)
    @HiveField(8) @Default(0) int satisfactionRank,

    /// 구매 후기
    @HiveField(9) @Default('') String review,

    /// 다시 사고 싶은지 여부
    @HiveField(10) @Default(false) bool wouldBuyAgain,

    /// 태그 목록
    @HiveField(11) @Default([]) List<String> tags,

    /// 생성 날짜 (위시리스트에 등록된 날짜)
    @HiveField(12) DateTime? createdAt,

    /// 메모
    @HiveField(13) @Default('') String memo,
  }) = _OwnedItem;

  factory OwnedItem.fromJson(Map<String, dynamic> json) =>
      _$OwnedItemFromJson(json);
}

/// OwnedItem 확장 메서드
extension OwnedItemExtension on OwnedItem {
  /// 가격 포맷팅 (예: ₩1,200,000)
  String get formattedPrice {
    return '₩${actualPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  /// 예상 가격 포맷팅
  String? get formattedExpectedPrice {
    if (expectedPrice == null) return null;
    return '₩${expectedPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  /// 가격 차이 (실제 - 예상)
  int? get priceDifference {
    if (expectedPrice == null) return null;
    return actualPrice - expectedPrice!;
  }

  /// 예상보다 저렴했는지
  bool get wasCheaper {
    if (expectedPrice == null) return false;
    return actualPrice < expectedPrice!;
  }

  /// 구매 후 경과 일수
  int get daysSincePurchase {
    return DateTime.now().difference(purchaseDate).inDays;
  }

  /// 위시리스트에 있던 기간 (일)
  int? get daysInWishlist {
    if (createdAt == null) return null;
    return purchaseDate.difference(createdAt!).inDays;
  }

  /// 이미지가 있는지 확인
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  /// 만족도 레벨 (High, Medium, Low)
  SatisfactionLevel get satisfactionLevel {
    if (satisfactionScore >= 4.0) return SatisfactionLevel.high;
    if (satisfactionScore >= 2.5) return SatisfactionLevel.medium;
    return SatisfactionLevel.low;
  }

  /// 가성비 점수 (만족도 / 가격 * 10000)
  double get valueForMoney {
    if (actualPrice == 0) return 0;
    return (satisfactionScore / actualPrice) * 10000;
  }
}

/// 만족도 레벨
enum SatisfactionLevel { high, medium, low }
