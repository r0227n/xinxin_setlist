import 'package:app/config/enviroment/src/flavor.dart';
import 'package:app/config/enviroment/src/production_firebase_options.dart'
    as prod;
import 'package:firebase_core/firebase_core.dart';

extension FlavorFirebaseOptions on Flavor {
  /// Returns the Firebase options for the current flavor.
  FirebaseOptions get firebaseOptions {
    return switch (this) {
      // Flavor.development => dev.DefaultFirebaseOptions.currentPlatform,
      Flavor.production => prod.DefaultFirebaseOptions.currentPlatform,
      _ => throw UnsupportedError('Unsupported flavor: $this'),
    };
  }
}
