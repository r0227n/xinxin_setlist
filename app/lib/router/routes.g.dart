// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeRoute];

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',

  factory: _$HomeRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'settings', factory: _$SettingsRoute._fromState),
    GoRouteData.$route(path: 'setlist', factory: _$SetlistRoute._fromState),
    GoRouteData.$route(
      path: 'setlist/:eventId',

      factory: _$SetlistDetailRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'setlist/music/:musicId',

      factory: _$SetlistMusicRoute._fromState,
    ),
  ],
);

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SetlistRoute on GoRouteData {
  static SetlistRoute _fromState(GoRouterState state) => const SetlistRoute();

  @override
  String get location => GoRouteData.$location('/setlist');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SetlistDetailRoute on GoRouteData {
  static SetlistDetailRoute _fromState(GoRouterState state) =>
      SetlistDetailRoute(eventId: state.pathParameters['eventId']!);

  SetlistDetailRoute get _self => this as SetlistDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/setlist/${Uri.encodeComponent(_self.eventId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SetlistMusicRoute on GoRouteData {
  static SetlistMusicRoute _fromState(GoRouterState state) =>
      SetlistMusicRoute(musicId: state.pathParameters['musicId']!);

  SetlistMusicRoute get _self => this as SetlistMusicRoute;

  @override
  String get location => GoRouteData.$location(
    '/setlist/music/${Uri.encodeComponent(_self.musicId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
