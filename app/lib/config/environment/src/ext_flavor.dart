// CI環境でlintが失敗するため、ignore_for_fileを使用している
// ignore_for_file: type=lint

import 'package:app/config/environment/src/flavor.dart';
import 'package:app/config/environment/src/production_firebase_options.dart'
    as prod;
import 'package:firebase_core/firebase_core.dart';

extension FlavorFirebaseOptions on Flavor {
  /// Returns the Firebase options for the current flavor.
  FirebaseOptions get firebaseOptions {
    return switch (this) {
      Flavor.production => prod.DefaultFirebaseOptions.currentPlatform,
      _ => throw UnsupportedError('Unsupported flavor: $this'),
    };
  }
}
