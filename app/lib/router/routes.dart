import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/setlist_page.dart';
import 'package:app/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SettingsRoute>(
      path: 'settings',
    ),
    TypedGoRoute<SetlistRoute>(
      path: 'setlist',
    ),
    TypedGoRoute<SetlistDetailRoute>(
      path: 'setlist/:eventId',
    ),
  ],
)
@immutable
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage(title: 'Flutter Demo Home Page');
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
class SetlistRoute extends GoRouteData with _$SetlistRoute {
  const SetlistRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SetlistPage();
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
