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

 String get id; String get eventId; List<String> get musicIds;
/// Create a copy of Setlist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetlistCopyWith<Setlist> get copyWith => _$SetlistCopyWithImpl<Setlist>(this as Setlist, _$identity);

  /// Serializes this Setlist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Setlist&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other.musicIds, musicIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,const DeepCollectionEquality().hash(musicIds));

@override
String toString() {
  return 'Setlist(id: $id, eventId: $eventId, musicIds: $musicIds)';
}


}

/// @nodoc
abstract mixin class $SetlistCopyWith<$Res>  {
  factory $SetlistCopyWith(Setlist value, $Res Function(Setlist) _then) = _$SetlistCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, List<String> musicIds
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? musicIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,musicIds: null == musicIds ? _self.musicIds : musicIds // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  List<String> musicIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Setlist() when $default != null:
return $default(_that.id,_that.eventId,_that.musicIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  List<String> musicIds)  $default,) {final _that = this;
switch (_that) {
case _Setlist():
return $default(_that.id,_that.eventId,_that.musicIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  List<String> musicIds)?  $default,) {final _that = this;
switch (_that) {
case _Setlist() when $default != null:
return $default(_that.id,_that.eventId,_that.musicIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Setlist implements Setlist {
  const _Setlist({required this.id, required this.eventId, required final  List<String> musicIds}): _musicIds = musicIds;
  factory _Setlist.fromJson(Map<String, dynamic> json) => _$SetlistFromJson(json);

@override final  String id;
@override final  String eventId;
 final  List<String> _musicIds;
@override List<String> get musicIds {
  if (_musicIds is EqualUnmodifiableListView) return _musicIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_musicIds);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Setlist&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._musicIds, _musicIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,const DeepCollectionEquality().hash(_musicIds));

@override
String toString() {
  return 'Setlist(id: $id, eventId: $eventId, musicIds: $musicIds)';
}


}

/// @nodoc
abstract mixin class _$SetlistCopyWith<$Res> implements $SetlistCopyWith<$Res> {
  factory _$SetlistCopyWith(_Setlist value, $Res Function(_Setlist) _then) = __$SetlistCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, List<String> musicIds
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? musicIds = null,}) {
  return _then(_Setlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,musicIds: null == musicIds ? _self._musicIds : musicIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
