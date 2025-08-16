///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsJa = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.ja,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <ja>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => Translations(meta: meta ?? this.$meta);

  // Translations
  String get share => '共有';
  late final TranslationsSettingsJa settings = TranslationsSettingsJa._(_root);
  late final TranslationsDialogJa dialog = TranslationsDialogJa._(_root);
  late final TranslationsSetlistJa setlist = TranslationsSetlistJa._(_root);
  late final TranslationsMusicJa music = TranslationsMusicJa._(_root);
  String get error => 'エラー';
}

// Path: settings
class TranslationsSettingsJa {
  TranslationsSettingsJa._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => '設定';
  String get language => '言語';
  String get theme => 'テーマ';
  String get version => 'バージョン';
  String get licenses => 'ライセンス';
}

// Path: dialog
class TranslationsDialogJa {
  TranslationsDialogJa._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get close => '閉じる';
  String get retry => '再試行';
}

// Path: setlist
class TranslationsSetlistJa {
  TranslationsSetlistJa._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'XINXIN SETLIST';
  late final TranslationsSetlistErrorJa error = TranslationsSetlistErrorJa._(
    _root,
  );
  late final TranslationsSetlistEmptyJa empty = TranslationsSetlistEmptyJa._(
    _root,
  );
  String get loading => '読み込み中...';
  String get date => '日付';
  String get adoption => 'セットリスト採用';
  String get times => '回';
}

// Path: music
class TranslationsMusicJa {
  TranslationsMusicJa._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get detail => '楽曲詳細';
}

// Path: setlist.error
class TranslationsSetlistErrorJa {
  TranslationsSetlistErrorJa._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get bothIdsSpecified => 'eventIdとmusicIdの両方を同時に指定することはできません';
  String get occurred => 'エラーが発生しました';
  String get dataFetchFailed => 'データ取得に失敗';
}

// Path: setlist.empty
class TranslationsSetlistEmptyJa {
  TranslationsSetlistEmptyJa._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get noSetlistForEvent => 'このイベントにはセットリストがありません';
  String get noSetlistForMusic => 'この音楽を含むセットリストがありません';
  String get noSetlist => 'セットリストがありません';
}
