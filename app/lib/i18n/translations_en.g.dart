///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEn({
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
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final TranslationsEn _root = this; // ignore: unused_field

  @override
  TranslationsEn $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsEn(meta: meta ?? this.$meta);

  // Translations
  @override
  String get hello => 'Hello';
  @override
  late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(
    _root,
  );
  @override
  late final _TranslationsDialogEn dialog = _TranslationsDialogEn._(_root);
  @override
  late final _TranslationsSetlistEn setlist = _TranslationsSetlistEn._(_root);
  @override
  late final _TranslationsMusicEn music = _TranslationsMusicEn._(_root);
  @override
  String get error => 'Error';
}

// Path: settings
class _TranslationsSettingsEn implements TranslationsSettingsJa {
  _TranslationsSettingsEn._(this._root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Settings';
  @override
  String get language => 'Language';
  @override
  String get theme => 'Theme';
  @override
  String get version => 'Version';
  @override
  String get licenses => 'Licenses';
  @override
  String get aboutXinxin => 'About XINXIN';
  @override
  String get aboutXinxinSubtitle => 'Please check the official X for details';
  @override
  String get inquiry => 'Inquiries about this site';
  @override
  String get inquirySubtitle =>
      'Please contact @r0227n for opinions, requests, questions, etc.';
}

// Path: dialog
class _TranslationsDialogEn implements TranslationsDialogJa {
  _TranslationsDialogEn._(this._root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get close => 'Close';
  @override
  String get retry => 'Retry';
}

// Path: setlist
class _TranslationsSetlistEn implements TranslationsSetlistJa {
  _TranslationsSetlistEn._(this._root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'XINXIN SETLIST';
  @override
  late final _TranslationsSetlistErrorEn error = _TranslationsSetlistErrorEn._(
    _root,
  );
  @override
  late final _TranslationsSetlistEmptyEn empty = _TranslationsSetlistEmptyEn._(
    _root,
  );
  @override
  String get loading => 'Loading...';
  @override
  String get date => 'Date';
  @override
  String get adoption => 'Setlist adoption';
  @override
  String get times => 'times';
}

// Path: music
class _TranslationsMusicEn implements TranslationsMusicJa {
  _TranslationsMusicEn._(this._root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get detail => 'Music Detail';
}

// Path: setlist.error
class _TranslationsSetlistErrorEn implements TranslationsSetlistErrorJa {
  _TranslationsSetlistErrorEn._(this._root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get bothIdsSpecified =>
      'Cannot specify both eventId and musicId simultaneously';
  @override
  String get occurred => 'An error occurred';
  @override
  String get dataFetchFailed => 'Failed to fetch data';
}

// Path: setlist.empty
class _TranslationsSetlistEmptyEn implements TranslationsSetlistEmptyJa {
  _TranslationsSetlistEmptyEn._(this._root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get noSetlistForEvent => 'No setlist for this event';
  @override
  String get noSetlistForMusic => 'No setlist containing this music';
  @override
  String get noSetlist => 'No setlist';
}
