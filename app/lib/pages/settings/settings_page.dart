import 'dart:async';

import 'package:app/i18n/translations.g.dart';
import 'package:app/router/routes.dart';
import 'package:app_preferences/app_preferences.dart' as app_prefs;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ListItem {
  const ListItem({
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
    GestureTapCallback? onTap,
  }) : _title = title,
       _subtitle = subtitle,
       _trailing = trailing,
       _onTap = onTap;

  final Widget _title;
  final Widget? _subtitle;
  final Widget? _trailing;
  final GestureTapCallback? _onTap;

  static Icon get iconChervon => const Icon(Icons.chevron_right);

  static Icon get iconOpenBrowser => const Icon(Icons.open_in_new);

  ListTile toListTile() {
    return ListTile(
      title: _title,
      subtitle: _subtitle,
      trailing: _trailing,
      onTap: _onTap,
    );
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);

    final children = [
      ListItem(
        title: Text(t.settings.language),
        subtitle: const app_prefs.LocaleText(),
        trailing: ListItem.iconChervon,
        onTap: () => _showLanguageDialog(context, t),
      ),
      ListItem(
        title: Text(t.settings.theme),
        subtitle: const app_prefs.ThemeText(),
        trailing: ListItem.iconChervon,
        onTap: () => _showThemeDialog(context, t),
      ),
      ListItem(
        title: Text(t.settings.aboutXinxin),
        subtitle: Text(t.settings.aboutXinxinSubtitle),
        trailing: ListItem.iconOpenBrowser,
        onTap: () => launchUrl(Uri.parse('https://x.com/xinxin_official')),
      ),
      ListItem(
        title: Text(t.settings.inquiry),
        subtitle: Text(t.settings.inquirySubtitle),
        trailing: ListItem.iconOpenBrowser,
        onTap: () => launchUrl(Uri.parse('https://x.com/r0227n')),
      ),
      ListItem(
        title: Text(t.settings.version),
        subtitle: const app_prefs.VersionText(),
        trailing: const Icon(Icons.info_outline),
      ),
      ListItem(
        title: Text(t.settings.licenses),
        trailing: ListItem.iconChervon,
        onTap: () => const LicenseRoute().go(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.title),
      ),
      body: ListView.separated(
        itemBuilder: (context, indext) {
          final item = children[indext];
          return item.toListTile();
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: children.length,
      ),
    );
  }

  Future<void> _showLanguageDialog(
    BuildContext context,
    Translations t,
  ) async {
    await app_prefs.PreferencesDialogHelpers.showLocaleSelectionDialog(
      context: context,
      title: t.settings.language,
      onLocaleChanged: (languageCode) async {
        // Update slang locale settings for immediate UI update
        final appLocale = AppLocale.values.firstWhere(
          (locale) => locale.languageCode == languageCode,
          orElse: () => AppLocale.ja,
        );
        unawaited(LocaleSettings.setLocale(appLocale));
      },
    );
  }

  Future<void> _showThemeDialog(
    BuildContext context,
    Translations t,
  ) async {
    await app_prefs.PreferencesDialogHelpers.showThemeSelectionDialog(
      context: context,
      title: t.settings.theme,
    );
  }
}
