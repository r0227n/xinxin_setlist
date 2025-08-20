import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flavor.g.dart';

@Riverpod(keepAlive: true)
Flavor flavor(Ref ref) => throw UnimplementedError();

enum Flavor {
  development,
  staging,
  production;

  const Flavor();

  factory Flavor.fromEnvironment() {
    // Required for build-time flavor configuration
    // ignore: do_not_use_environment
    const environment = String.fromEnvironment(
      'FLAVOR',
    );

    return Flavor.values.byName(environment);
  }
}
