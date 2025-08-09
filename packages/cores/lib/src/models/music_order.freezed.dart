// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'music_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MusicOrder {

 String get id;// ランダム
 String get eventId;// 外部キー
 String get musicId;// 外部キー
 int get order;
/// Create a copy of MusicOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MusicOrderCopyWith<MusicOrder> get copyWith => _$MusicOrderCopyWithImpl<MusicOrder>(this as MusicOrder, _$identity);

  /// Serializes this MusicOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MusicOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.musicId, musicId) || other.musicId == musicId)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,musicId,order);

@override
String toString() {
  return 'MusicOrder(id: $id, eventId: $eventId, musicId: $musicId, order: $order)';
}


}

/// @nodoc
abstract mixin class $MusicOrderCopyWith<$Res>  {
  factory $MusicOrderCopyWith(MusicOrder value, $Res Function(MusicOrder) _then) = _$MusicOrderCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, String musicId, int order
});




}
/// @nodoc
class _$MusicOrderCopyWithImpl<$Res>
    implements $MusicOrderCopyWith<$Res> {
  _$MusicOrderCopyWithImpl(this._self, this._then);

  final MusicOrder _self;
  final $Res Function(MusicOrder) _then;

/// Create a copy of MusicOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? musicId = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,musicId: null == musicId ? _self.musicId : musicId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MusicOrder].
extension MusicOrderPatterns on MusicOrder {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MusicOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MusicOrder() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MusicOrder value)  $default,){
final _that = this;
switch (_that) {
case _MusicOrder():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MusicOrder value)?  $default,){
final _that = this;
switch (_that) {
case _MusicOrder() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  String musicId,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MusicOrder() when $default != null:
return $default(_that.id,_that.eventId,_that.musicId,_that.order);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  String musicId,  int order)  $default,) {final _that = this;
switch (_that) {
case _MusicOrder():
return $default(_that.id,_that.eventId,_that.musicId,_that.order);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  String musicId,  int order)?  $default,) {final _that = this;
switch (_that) {
case _MusicOrder() when $default != null:
return $default(_that.id,_that.eventId,_that.musicId,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MusicOrder implements MusicOrder {
  const _MusicOrder({required this.id, required this.eventId, required this.musicId, required this.order});
  factory _MusicOrder.fromJson(Map<String, dynamic> json) => _$MusicOrderFromJson(json);

@override final  String id;
// ランダム
@override final  String eventId;
// 外部キー
@override final  String musicId;
// 外部キー
@override final  int order;

/// Create a copy of MusicOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MusicOrderCopyWith<_MusicOrder> get copyWith => __$MusicOrderCopyWithImpl<_MusicOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MusicOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MusicOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.musicId, musicId) || other.musicId == musicId)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,musicId,order);

@override
String toString() {
  return 'MusicOrder(id: $id, eventId: $eventId, musicId: $musicId, order: $order)';
}


}

/// @nodoc
abstract mixin class _$MusicOrderCopyWith<$Res> implements $MusicOrderCopyWith<$Res> {
  factory _$MusicOrderCopyWith(_MusicOrder value, $Res Function(_MusicOrder) _then) = __$MusicOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, String musicId, int order
});




}
/// @nodoc
class __$MusicOrderCopyWithImpl<$Res>
    implements _$MusicOrderCopyWith<$Res> {
  __$MusicOrderCopyWithImpl(this._self, this._then);

  final _MusicOrder _self;
  final $Res Function(_MusicOrder) _then;

/// Create a copy of MusicOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? musicId = null,Object? order = null,}) {
  return _then(_MusicOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,musicId: null == musicId ? _self.musicId : musicId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
