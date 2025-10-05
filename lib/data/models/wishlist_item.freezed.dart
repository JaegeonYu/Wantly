// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) {
  return _WishlistItem.fromJson(json);
}

/// @nodoc
mixin _$WishlistItem {
  /// 고유 ID
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;

  /// 물품명
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;

  /// 예상 가격 (원 단위)
  @HiveField(2)
  int get price => throw _privateConstructorUsedError;

  /// 이미지 경로 (로컬 저장소)
  @HiveField(3)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// 사고 싶은 이유
  @HiveField(4)
  String get reason => throw _privateConstructorUsedError;

  /// 카테고리 ID
  @HiveField(5)
  String get categoryId => throw _privateConstructorUsedError;

  /// 우선순위 (숫자가 작을수록 높음)
  @HiveField(6)
  int get priority => throw _privateConstructorUsedError;

  /// 생성 날짜
  @HiveField(7)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 수정 날짜
  @HiveField(8)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// 태그 목록
  @HiveField(9)
  List<String> get tags => throw _privateConstructorUsedError;

  /// 메모 (추가 정보)
  @HiveField(10)
  String get memo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WishlistItemCopyWith<WishlistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistItemCopyWith<$Res> {
  factory $WishlistItemCopyWith(
          WishlistItem value, $Res Function(WishlistItem) then) =
      _$WishlistItemCopyWithImpl<$Res, WishlistItem>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int price,
      @HiveField(3) String? imageUrl,
      @HiveField(4) String reason,
      @HiveField(5) String categoryId,
      @HiveField(6) int priority,
      @HiveField(7) DateTime createdAt,
      @HiveField(8) DateTime? updatedAt,
      @HiveField(9) List<String> tags,
      @HiveField(10) String memo});
}

/// @nodoc
class _$WishlistItemCopyWithImpl<$Res, $Val extends WishlistItem>
    implements $WishlistItemCopyWith<$Res> {
  _$WishlistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? reason = null,
    Object? categoryId = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? tags = null,
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
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WishlistItemImplCopyWith<$Res>
    implements $WishlistItemCopyWith<$Res> {
  factory _$$WishlistItemImplCopyWith(
          _$WishlistItemImpl value, $Res Function(_$WishlistItemImpl) then) =
      __$$WishlistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int price,
      @HiveField(3) String? imageUrl,
      @HiveField(4) String reason,
      @HiveField(5) String categoryId,
      @HiveField(6) int priority,
      @HiveField(7) DateTime createdAt,
      @HiveField(8) DateTime? updatedAt,
      @HiveField(9) List<String> tags,
      @HiveField(10) String memo});
}

/// @nodoc
class __$$WishlistItemImplCopyWithImpl<$Res>
    extends _$WishlistItemCopyWithImpl<$Res, _$WishlistItemImpl>
    implements _$$WishlistItemImplCopyWith<$Res> {
  __$$WishlistItemImplCopyWithImpl(
      _$WishlistItemImpl _value, $Res Function(_$WishlistItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? reason = null,
    Object? categoryId = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? tags = null,
    Object? memo = null,
  }) {
    return _then(_$WishlistItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishlistItemImpl implements _WishlistItem {
  const _$WishlistItemImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.price,
      @HiveField(3) this.imageUrl,
      @HiveField(4) this.reason = '',
      @HiveField(5) required this.categoryId,
      @HiveField(6) this.priority = 0,
      @HiveField(7) required this.createdAt,
      @HiveField(8) this.updatedAt,
      @HiveField(9) final List<String> tags = const [],
      @HiveField(10) this.memo = ''})
      : _tags = tags;

  factory _$WishlistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishlistItemImplFromJson(json);

  /// 고유 ID
  @override
  @HiveField(0)
  final String id;

  /// 물품명
  @override
  @HiveField(1)
  final String name;

  /// 예상 가격 (원 단위)
  @override
  @HiveField(2)
  final int price;

  /// 이미지 경로 (로컬 저장소)
  @override
  @HiveField(3)
  final String? imageUrl;

  /// 사고 싶은 이유
  @override
  @JsonKey()
  @HiveField(4)
  final String reason;

  /// 카테고리 ID
  @override
  @HiveField(5)
  final String categoryId;

  /// 우선순위 (숫자가 작을수록 높음)
  @override
  @JsonKey()
  @HiveField(6)
  final int priority;

  /// 생성 날짜
  @override
  @HiveField(7)
  final DateTime createdAt;

  /// 수정 날짜
  @override
  @HiveField(8)
  final DateTime? updatedAt;

  /// 태그 목록
  final List<String> _tags;

  /// 태그 목록
  @override
  @JsonKey()
  @HiveField(9)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// 메모 (추가 정보)
  @override
  @JsonKey()
  @HiveField(10)
  final String memo;

  @override
  String toString() {
    return 'WishlistItem(id: $id, name: $name, price: $price, imageUrl: $imageUrl, reason: $reason, categoryId: $categoryId, priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt, tags: $tags, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      imageUrl,
      reason,
      categoryId,
      priority,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_tags),
      memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WishlistItemImplCopyWith<_$WishlistItemImpl> get copyWith =>
      __$$WishlistItemImplCopyWithImpl<_$WishlistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishlistItemImplToJson(
      this,
    );
  }
}

abstract class _WishlistItem implements WishlistItem {
  const factory _WishlistItem(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final int price,
      @HiveField(3) final String? imageUrl,
      @HiveField(4) final String reason,
      @HiveField(5) required final String categoryId,
      @HiveField(6) final int priority,
      @HiveField(7) required final DateTime createdAt,
      @HiveField(8) final DateTime? updatedAt,
      @HiveField(9) final List<String> tags,
      @HiveField(10) final String memo}) = _$WishlistItemImpl;

  factory _WishlistItem.fromJson(Map<String, dynamic> json) =
      _$WishlistItemImpl.fromJson;

  @override

  /// 고유 ID
  @HiveField(0)
  String get id;
  @override

  /// 물품명
  @HiveField(1)
  String get name;
  @override

  /// 예상 가격 (원 단위)
  @HiveField(2)
  int get price;
  @override

  /// 이미지 경로 (로컬 저장소)
  @HiveField(3)
  String? get imageUrl;
  @override

  /// 사고 싶은 이유
  @HiveField(4)
  String get reason;
  @override

  /// 카테고리 ID
  @HiveField(5)
  String get categoryId;
  @override

  /// 우선순위 (숫자가 작을수록 높음)
  @HiveField(6)
  int get priority;
  @override

  /// 생성 날짜
  @HiveField(7)
  DateTime get createdAt;
  @override

  /// 수정 날짜
  @HiveField(8)
  DateTime? get updatedAt;
  @override

  /// 태그 목록
  @HiveField(9)
  List<String> get tags;
  @override

  /// 메모 (추가 정보)
  @HiveField(10)
  String get memo;
  @override
  @JsonKey(ignore: true)
  _$$WishlistItemImplCopyWith<_$WishlistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
