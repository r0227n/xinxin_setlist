import 'package:app/pages/music_detail_page.dart';
import 'package:app/pages/setlist_page.dart';
import 'package:app/pages/settings/custom_license_page.dart';
import 'package:app/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<SetlistRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SettingsRoute>(
      path: 'settings',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<LicenseRoute>(
          path: 'license',
        ),
      ],
    ),
    TypedGoRoute<SetlistDetailRoute>(
      path: 'setlist/:eventId',
    ),
    TypedGoRoute<SetlistMusicRoute>(
      path: 'setlist/music/:musicId',
    ),
    TypedGoRoute<MusicDetailRoute>(
      path: 'music/:musicId',
    ),
  ],
)
@immutable
class SetlistRoute extends GoRouteData with _$SetlistRoute {
  const SetlistRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SetlistPage();
  }
}

@immutable
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@immutable
class SetlistDetailRoute extends GoRouteData with _$SetlistDetailRoute {
  const SetlistDetailRoute({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SetlistPage(eventId: eventId);
  }
}

@immutable
class LicenseRoute extends GoRouteData with _$LicenseRoute {
  const LicenseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CustomLicensePage();
  }
}

@immutable
class SetlistMusicRoute extends GoRouteData with _$SetlistMusicRoute {
  const SetlistMusicRoute({required this.musicId});

  final String musicId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SetlistPage(musicId: musicId);
  }
}

@immutable
class MusicDetailRoute extends GoRouteData with _$MusicDetailRoute {
  const MusicDetailRoute({required this.musicId});

  final String musicId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MusicDetailPage(musicId: musicId);
  }
}
