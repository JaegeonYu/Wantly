// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owned_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OwnedItem _$OwnedItemFromJson(Map<String, dynamic> json) {
  return _OwnedItem.fromJson(json);
}

/// @nodoc
mixin _$OwnedItem {
  /// 고유 ID
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;

  /// 물품명
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;

  /// 실제 구매 가격 (원 단위)
  @HiveField(2)
  int get actualPrice => throw _privateConstructorUsedError;

  /// 예상 가격 (위시리스트에 있을 때)
  @HiveField(3)
  int? get expectedPrice => throw _privateConstructorUsedError;

  /// 이미지 경로 (로컬 저장소)
  @HiveField(4)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// 카테고리 ID
  @HiveField(5)
  String get categoryId => throw _privateConstructorUsedError;

  /// 구매 날짜
  @HiveField(6)
  DateTime get purchaseDate => throw _privateConstructorUsedError;

  /// 만족도 점수 (1.0 ~ 5.0)
  @HiveField(7)
  double get satisfactionScore => throw _privateConstructorUsedError;

  /// 만족도 순위 (드래그앤드롭용, 숫자가 작을수록 높음)
  @HiveField(8)
  int get satisfactionRank => throw _privateConstructorUsedError;

  /// 구매 후기
  @HiveField(9)
  String get review => throw _privateConstructorUsedError;

  /// 다시 사고 싶은지 여부
  @HiveField(10)
  bool get wouldBuyAgain => throw _privateConstructorUsedError;

  /// 태그 목록
  @HiveField(11)
  List<String> get tags => throw _privateConstructorUsedError;

  /// 생성 날짜 (위시리스트에 등록된 날짜)
  @HiveField(12)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// 메모
  @HiveField(13)
  String get memo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OwnedItemCopyWith<OwnedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnedItemCopyWith<$Res> {
  factory $OwnedItemCopyWith(OwnedItem value, $Res Function(OwnedItem) then) =
      _$OwnedItemCopyWithImpl<$Res, OwnedItem>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int actualPrice,
      @HiveField(3) int? expectedPrice,
      @HiveField(4) String? imageUrl,
      @HiveField(5) String categoryId,
      @HiveField(6) DateTime purchaseDate,
      @HiveField(7) double satisfactionScore,
      @HiveField(8) int satisfactionRank,
      @HiveField(9) String review,
      @HiveField(10) bool wouldBuyAgain,
      @HiveField(11) List<String> tags,
      @HiveField(12) DateTime? createdAt,
      @HiveField(13) String memo});
}

/// @nodoc
class _$OwnedItemCopyWithImpl<$Res, $Val extends OwnedItem>
    implements $OwnedItemCopyWith<$Res> {
  _$OwnedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? actualPrice = null,
    Object? expectedPrice = freezed,
    Object? imageUrl = freezed,
    Object? categoryId = null,
    Object? purchaseDate = null,
    Object? satisfactionScore = null,
    Object? satisfactionRank = null,
    Object? review = null,
    Object? wouldBuyAgain = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? memo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      actualPrice: null == actualPrice
          ? _value.actualPrice
          : actualPrice // ignore: cast_nullable_to_non_nullable
              as int,
      expectedPrice: freezed == expectedPrice
          ? _value.expectedPrice
          : expectedPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      satisfactionScore: null == satisfactionScore
          ? _value.satisfactionScore
          : satisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      satisfactionRank: null == satisfactionRank
          ? _value.satisfactionRank
          : satisfactionRank // ignore: cast_nullable_to_non_nullable
              as int,
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
      wouldBuyAgain: null == wouldBuyAgain
          ? _value.wouldBuyAgain
          : wouldBuyAgain // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OwnedItemImplCopyWith<$Res>
    implements $OwnedItemCopyWith<$Res> {
  factory _$$OwnedItemImplCopyWith(
          _$OwnedItemImpl value, $Res Function(_$OwnedItemImpl) then) =
      __$$OwnedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int actualPrice,
      @HiveField(3) int? expectedPrice,
      @HiveField(4) String? imageUrl,
      @HiveField(5) String categoryId,
      @HiveField(6) DateTime purchaseDate,
      @HiveField(7) double satisfactionScore,
      @HiveField(8) int satisfactionRank,
      @HiveField(9) String review,
      @HiveField(10) bool wouldBuyAgain,
      @HiveField(11) List<String> tags,
      @HiveField(12) DateTime? createdAt,
      @HiveField(13) String memo});
}

/// @nodoc
class __$$OwnedItemImplCopyWithImpl<$Res>
    extends _$OwnedItemCopyWithImpl<$Res, _$OwnedItemImpl>
    implements _$$OwnedItemImplCopyWith<$Res> {
  __$$OwnedItemImplCopyWithImpl(
      _$OwnedItemImpl _value, $Res Function(_$OwnedItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? actualPrice = null,
    Object? expectedPrice = freezed,
    Object? imageUrl = freezed,
    Object? categoryId = null,
    Object? purchaseDate = null,
    Object? satisfactionScore = null,
    Object? satisfactionRank = null,
    Object? review = null,
    Object? wouldBuyAgain = null,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? memo = null,
  }) {
    return _then(_$OwnedItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      actualPrice: null == actualPrice
          ? _value.actualPrice
          : actualPrice // ignore: cast_nullable_to_non_nullable
              as int,
      expectedPrice: freezed == expectedPrice
          ? _value.expectedPrice
          : expectedPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      satisfactionScore: null == satisfactionScore
          ? _value.satisfactionScore
          : satisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      satisfactionRank: null == satisfactionRank
          ? _value.satisfactionRank
          : satisfactionRank // ignore: cast_nullable_to_non_nullable
              as int,
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
      wouldBuyAgain: null == wouldBuyAgain
          ? _value.wouldBuyAgain
          : wouldBuyAgain // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OwnedItemImpl implements _OwnedItem {
  const _$OwnedItemImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.actualPrice,
      @HiveField(3) this.expectedPrice,
      @HiveField(4) this.imageUrl,
      @HiveField(5) required this.categoryId,
      @HiveField(6) required this.purchaseDate,
      @HiveField(7) this.satisfactionScore = 3.0,
      @HiveField(8) this.satisfactionRank = 0,
      @HiveField(9) this.review = '',
      @HiveField(10) this.wouldBuyAgain = false,
      @HiveField(11) final List<String> tags = const [],
      @HiveField(12) this.createdAt,
      @HiveField(13) this.memo = ''})
      : _tags = tags;

  factory _$OwnedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OwnedItemImplFromJson(json);

  /// 고유 ID
  @override
  @HiveField(0)
  final String id;

  /// 물품명
  @override
  @HiveField(1)
  final String name;

  /// 실제 구매 가격 (원 단위)
  @override
  @HiveField(2)
  final int actualPrice;

  /// 예상 가격 (위시리스트에 있을 때)
  @override
  @HiveField(3)
  final int? expectedPrice;

  /// 이미지 경로 (로컬 저장소)
  @override
  @HiveField(4)
  final String? imageUrl;

  /// 카테고리 ID
  @override
  @HiveField(5)
  final String categoryId;

  /// 구매 날짜
  @override
  @HiveField(6)
  final DateTime purchaseDate;

  /// 만족도 점수 (1.0 ~ 5.0)
  @override
  @JsonKey()
  @HiveField(7)
  final double satisfactionScore;

  /// 만족도 순위 (드래그앤드롭용, 숫자가 작을수록 높음)
  @override
  @JsonKey()
  @HiveField(8)
  final int satisfactionRank;

  /// 구매 후기
  @override
  @JsonKey()
  @HiveField(9)
  final String review;

  /// 다시 사고 싶은지 여부
  @override
  @JsonKey()
  @HiveField(10)
  final bool wouldBuyAgain;

  /// 태그 목록
  final List<String> _tags;

  /// 태그 목록
  @override
  @JsonKey()
  @HiveField(11)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// 생성 날짜 (위시리스트에 등록된 날짜)
  @override
  @HiveField(12)
  final DateTime? createdAt;

  /// 메모
  @override
  @JsonKey()
  @HiveField(13)
  final String memo;

  @override
  String toString() {
    return 'OwnedItem(id: $id, name: $name, actualPrice: $actualPrice, expectedPrice: $expectedPrice, imageUrl: $imageUrl, categoryId: $categoryId, purchaseDate: $purchaseDate, satisfactionScore: $satisfactionScore, satisfactionRank: $satisfactionRank, review: $review, wouldBuyAgain: $wouldBuyAgain, tags: $tags, createdAt: $createdAt, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnedItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.actualPrice, actualPrice) ||
                other.actualPrice == actualPrice) &&
            (identical(other.expectedPrice, expectedPrice) ||
                other.expectedPrice == expectedPrice) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.satisfactionScore, satisfactionScore) ||
                other.satisfactionScore == satisfactionScore) &&
            (identical(other.satisfactionRank, satisfactionRank) ||
                other.satisfactionRank == satisfactionRank) &&
            (identical(other.review, review) || other.review == review) &&
            (identical(other.wouldBuyAgain, wouldBuyAgain) ||
                other.wouldBuyAgain == wouldBuyAgain) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      actualPrice,
      expectedPrice,
      imageUrl,
      categoryId,
      purchaseDate,
      satisfactionScore,
      satisfactionRank,
      review,
      wouldBuyAgain,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnedItemImplCopyWith<_$OwnedItemImpl> get copyWith =>
      __$$OwnedItemImplCopyWithImpl<_$OwnedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OwnedItemImplToJson(
      this,
    );
  }
}

abstract class _OwnedItem implements OwnedItem {
  const factory _OwnedItem(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final int actualPrice,
      @HiveField(3) final int? expectedPrice,
      @HiveField(4) final String? imageUrl,
      @HiveField(5) required final String categoryId,
      @HiveField(6) required final DateTime purchaseDate,
      @HiveField(7) final double satisfactionScore,
      @HiveField(8) final int satisfactionRank,
      @HiveField(9) final String review,
      @HiveField(10) final bool wouldBuyAgain,
      @HiveField(11) final List<String> tags,
      @HiveField(12) final DateTime? createdAt,
      @HiveField(13) final String memo}) = _$OwnedItemImpl;

  factory _OwnedItem.fromJson(Map<String, dynamic> json) =
      _$OwnedItemImpl.fromJson;

  @override

  /// 고유 ID
  @HiveField(0)
  String get id;
  @override

  /// 물품명
  @HiveField(1)
  String get name;
  @override

  /// 실제 구매 가격 (원 단위)
  @HiveField(2)
  int get actualPrice;
  @override

  /// 예상 가격 (위시리스트에 있을 때)
  @HiveField(3)
  int? get expectedPrice;
  @override

  /// 이미지 경로 (로컬 저장소)
  @HiveField(4)
  String? get imageUrl;
  @override

  /// 카테고리 ID
  @HiveField(5)
  String get categoryId;
  @override

  /// 구매 날짜
  @HiveField(6)
  DateTime get purchaseDate;
  @override

  /// 만족도 점수 (1.0 ~ 5.0)
  @HiveField(7)
  double get satisfactionScore;
  @override

  /// 만족도 순위 (드래그앤드롭용, 숫자가 작을수록 높음)
  @HiveField(8)
  int get satisfactionRank;
  @override

  /// 구매 후기
  @HiveField(9)
  String get review;
  @override

  /// 다시 사고 싶은지 여부
  @HiveField(10)
  bool get wouldBuyAgain;
  @override

  /// 태그 목록
  @HiveField(11)
  List<String> get tags;
  @override

  /// 생성 날짜 (위시리스트에 등록된 날짜)
  @HiveField(12)
  DateTime? get createdAt;
  @override

  /// 메모
  @HiveField(13)
  String get memo;
  @override
  @JsonKey(ignore: true)
  _$$OwnedItemImplCopyWith<_$OwnedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
