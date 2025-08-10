// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 String get id;// date_ランダム
@JsonKey(name: 'stage_id') String get stageId; String get title; DateTime get date; List<SetlistItem> get setlist; int? get order;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.setlist, setlist)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,stageId,title,date,const DeepCollectionEquality().hash(setlist),order);

@override
String toString() {
  return 'Event(id: $id, stageId: $stageId, title: $title, date: $date, setlist: $setlist, order: $order)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'stage_id') String stageId, String title, DateTime date, List<SetlistItem> setlist, int? order
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? stageId = null,Object? title = null,Object? date = null,Object? setlist = null,Object? order = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,stageId: null == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,setlist: null == setlist ? _self.setlist : setlist // ignore: cast_nullable_to_non_nullable
as List<SetlistItem>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'stage_id')  String stageId,  String title,  DateTime date,  List<SetlistItem> setlist,  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.stageId,_that.title,_that.date,_that.setlist,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'stage_id')  String stageId,  String title,  DateTime date,  List<SetlistItem> setlist,  int? order)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.stageId,_that.title,_that.date,_that.setlist,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'stage_id')  String stageId,  String title,  DateTime date,  List<SetlistItem> setlist,  int? order)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.stageId,_that.title,_that.date,_that.setlist,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, @JsonKey(name: 'stage_id') required this.stageId, required this.title, required this.date, required final  List<SetlistItem> setlist, this.order}): _setlist = setlist;
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
// date_ランダム
@override@JsonKey(name: 'stage_id') final  String stageId;
@override final  String title;
@override final  DateTime date;
 final  List<SetlistItem> _setlist;
@override List<SetlistItem> get setlist {
  if (_setlist is EqualUnmodifiableListView) return _setlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_setlist);
}

@override final  int? order;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.stageId, stageId) || other.stageId == stageId)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._setlist, _setlist)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,stageId,title,date,const DeepCollectionEquality().hash(_setlist),order);

@override
String toString() {
  return 'Event(id: $id, stageId: $stageId, title: $title, date: $date, setlist: $setlist, order: $order)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'stage_id') String stageId, String title, DateTime date, List<SetlistItem> setlist, int? order
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? stageId = null,Object? title = null,Object? date = null,Object? setlist = null,Object? order = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,stageId: null == stageId ? _self.stageId : stageId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,setlist: null == setlist ? _self._setlist : setlist // ignore: cast_nullable_to_non_nullable
as List<SetlistItem>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SetlistItem {

 String get id;@JsonKey(name: 'music_id') String get musicId; int get order;
/// Create a copy of SetlistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetlistItemCopyWith<SetlistItem> get copyWith => _$SetlistItemCopyWithImpl<SetlistItem>(this as SetlistItem, _$identity);

  /// Serializes this SetlistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetlistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.musicId, musicId) || other.musicId == musicId)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,musicId,order);

@override
String toString() {
  return 'SetlistItem(id: $id, musicId: $musicId, order: $order)';
}


}

/// @nodoc
abstract mixin class $SetlistItemCopyWith<$Res>  {
  factory $SetlistItemCopyWith(SetlistItem value, $Res Function(SetlistItem) _then) = _$SetlistItemCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'music_id') String musicId, int order
});




}
/// @nodoc
class _$SetlistItemCopyWithImpl<$Res>
    implements $SetlistItemCopyWith<$Res> {
  _$SetlistItemCopyWithImpl(this._self, this._then);

  final SetlistItem _self;
  final $Res Function(SetlistItem) _then;

/// Create a copy of SetlistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? musicId = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,musicId: null == musicId ? _self.musicId : musicId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SetlistItem].
extension SetlistItemPatterns on SetlistItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetlistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetlistItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetlistItem value)  $default,){
final _that = this;
switch (_that) {
case _SetlistItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetlistItem value)?  $default,){
final _that = this;
switch (_that) {
case _SetlistItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'music_id')  String musicId,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetlistItem() when $default != null:
return $default(_that.id,_that.musicId,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'music_id')  String musicId,  int order)  $default,) {final _that = this;
switch (_that) {
case _SetlistItem():
return $default(_that.id,_that.musicId,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'music_id')  String musicId,  int order)?  $default,) {final _that = this;
switch (_that) {
case _SetlistItem() when $default != null:
return $default(_that.id,_that.musicId,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetlistItem implements SetlistItem {
  const _SetlistItem({required this.id, @JsonKey(name: 'music_id') required this.musicId, required this.order});
  factory _SetlistItem.fromJson(Map<String, dynamic> json) => _$SetlistItemFromJson(json);

@override final  String id;
@override@JsonKey(name: 'music_id') final  String musicId;
@override final  int order;

/// Create a copy of SetlistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetlistItemCopyWith<_SetlistItem> get copyWith => __$SetlistItemCopyWithImpl<_SetlistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetlistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetlistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.musicId, musicId) || other.musicId == musicId)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,musicId,order);

@override
String toString() {
  return 'SetlistItem(id: $id, musicId: $musicId, order: $order)';
}


}

/// @nodoc
abstract mixin class _$SetlistItemCopyWith<$Res> implements $SetlistItemCopyWith<$Res> {
  factory _$SetlistItemCopyWith(_SetlistItem value, $Res Function(_SetlistItem) _then) = __$SetlistItemCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'music_id') String musicId, int order
});




}
/// @nodoc
class __$SetlistItemCopyWithImpl<$Res>
    implements _$SetlistItemCopyWith<$Res> {
  __$SetlistItemCopyWithImpl(this._self, this._then);

  final _SetlistItem _self;
  final $Res Function(_SetlistItem) _then;

/// Create a copy of SetlistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? musicId = null,Object? order = null,}) {
  return _then(_SetlistItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,musicId: null == musicId ? _self.musicId : musicId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
