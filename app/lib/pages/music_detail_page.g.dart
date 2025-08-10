// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_detail_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$musicDetailHash() => r'7476c28b850537ee7f0014e8bc782376543b1b81';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// musicId で指定された楽曲の詳細情報を取得するProvider
///
/// Copied from [musicDetail].
@ProviderFor(musicDetail)
const musicDetailProvider = MusicDetailFamily();

/// musicId で指定された楽曲の詳細情報を取得するProvider
///
/// Copied from [musicDetail].
class MusicDetailFamily extends Family<AsyncValue<Music>> {
  /// musicId で指定された楽曲の詳細情報を取得するProvider
  ///
  /// Copied from [musicDetail].
  const MusicDetailFamily();

  /// musicId で指定された楽曲の詳細情報を取得するProvider
  ///
  /// Copied from [musicDetail].
  MusicDetailProvider call(String musicId) {
    return MusicDetailProvider(musicId);
  }

  @override
  MusicDetailProvider getProviderOverride(
    covariant MusicDetailProvider provider,
  ) {
    return call(provider.musicId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'musicDetailProvider';
}

/// musicId で指定された楽曲の詳細情報を取得するProvider
///
/// Copied from [musicDetail].
class MusicDetailProvider extends AutoDisposeFutureProvider<Music> {
  /// musicId で指定された楽曲の詳細情報を取得するProvider
  ///
  /// Copied from [musicDetail].
  MusicDetailProvider(String musicId)
    : this._internal(
        (ref) => musicDetail(ref as MusicDetailRef, musicId),
        from: musicDetailProvider,
        name: r'musicDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$musicDetailHash,
        dependencies: MusicDetailFamily._dependencies,
        allTransitiveDependencies: MusicDetailFamily._allTransitiveDependencies,
        musicId: musicId,
      );

  MusicDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.musicId,
  }) : super.internal();

  final String musicId;

  @override
  Override overrideWith(
    FutureOr<Music> Function(MusicDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MusicDetailProvider._internal(
        (ref) => create(ref as MusicDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        musicId: musicId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Music> createElement() {
    return _MusicDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MusicDetailProvider && other.musicId == musicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, musicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MusicDetailRef on AutoDisposeFutureProviderRef<Music> {
  /// The parameter `musicId` of this provider.
  String get musicId;
}

class _MusicDetailProviderElement
    extends AutoDisposeFutureProviderElement<Music>
    with MusicDetailRef {
  _MusicDetailProviderElement(super.provider);

  @override
  String get musicId => (origin as MusicDetailProvider).musicId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
