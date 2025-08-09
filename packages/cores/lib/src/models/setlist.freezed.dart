// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Setlist {

 String get id; List<String> get musicOrderIds;
/// Create a copy of Setlist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetlistCopyWith<Setlist> get copyWith => _$SetlistCopyWithImpl<Setlist>(this as Setlist, _$identity);

  /// Serializes this Setlist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Setlist&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.musicOrderIds, musicOrderIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(musicOrderIds));

@override
String toString() {
  return 'Setlist(id: $id, musicOrderIds: $musicOrderIds)';
}


}

/// @nodoc
abstract mixin class $SetlistCopyWith<$Res>  {
  factory $SetlistCopyWith(Setlist value, $Res Function(Setlist) _then) = _$SetlistCopyWithImpl;
@useResult
$Res call({
 String id, List<String> musicOrderIds
});




}
/// @nodoc
class _$SetlistCopyWithImpl<$Res>
    implements $SetlistCopyWith<$Res> {
  _$SetlistCopyWithImpl(this._self, this._then);

  final Setlist _self;
  final $Res Function(Setlist) _then;

/// Create a copy of Setlist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? musicOrderIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,musicOrderIds: null == musicOrderIds ? _self.musicOrderIds : musicOrderIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Setlist].
extension SetlistPatterns on Setlist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Setlist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Setlist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Setlist value)  $default,){
final _that = this;
switch (_that) {
case _Setlist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Setlist value)?  $default,){
final _that = this;
switch (_that) {
case _Setlist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<String> musicOrderIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Setlist() when $default != null:
return $default(_that.id,_that.musicOrderIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<String> musicOrderIds)  $default,) {final _that = this;
switch (_that) {
case _Setlist():
return $default(_that.id,_that.musicOrderIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<String> musicOrderIds)?  $default,) {final _that = this;
switch (_that) {
case _Setlist() when $default != null:
return $default(_that.id,_that.musicOrderIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Setlist implements Setlist {
  const _Setlist({required this.id, required final  List<String> musicOrderIds}): _musicOrderIds = musicOrderIds;
  factory _Setlist.fromJson(Map<String, dynamic> json) => _$SetlistFromJson(json);

@override final  String id;
 final  List<String> _musicOrderIds;
@override List<String> get musicOrderIds {
  if (_musicOrderIds is EqualUnmodifiableListView) return _musicOrderIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_musicOrderIds);
}


/// Create a copy of Setlist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetlistCopyWith<_Setlist> get copyWith => __$SetlistCopyWithImpl<_Setlist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetlistToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Setlist&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._musicOrderIds, _musicOrderIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_musicOrderIds));

@override
String toString() {
  return 'Setlist(id: $id, musicOrderIds: $musicOrderIds)';
}


}

/// @nodoc
abstract mixin class _$SetlistCopyWith<$Res> implements $SetlistCopyWith<$Res> {
  factory _$SetlistCopyWith(_Setlist value, $Res Function(_Setlist) _then) = __$SetlistCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> musicOrderIds
});




}
/// @nodoc
class __$SetlistCopyWithImpl<$Res>
    implements _$SetlistCopyWith<$Res> {
  __$SetlistCopyWithImpl(this._self, this._then);

  final _Setlist _self;
  final $Res Function(_Setlist) _then;

/// Create a copy of Setlist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? musicOrderIds = null,}) {
  return _then(_Setlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,musicOrderIds: null == musicOrderIds ? _self._musicOrderIds : musicOrderIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
