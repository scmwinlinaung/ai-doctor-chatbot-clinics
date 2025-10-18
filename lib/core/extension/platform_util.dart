import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

extension PlatformInfo on BuildContext {
  /// Returns true if the app is running on a mobile platform (Android or iOS).
  bool get isMobile {
    if (kIsWeb) {
      return false;
    }
    // Using `Platform` from dart:io requires a non-web check
    return Platform.isIOS || Platform.isAndroid;
  }

  /// Returns true if the app is running on a desktop platform.
  bool get isDesktop {
    if (kIsWeb) {
      return false;
    }
    // Using `Platform` from dart:io requires a non-web check
    return Platform.isLinux ||
        Platform.isFuchsia ||
        Platform.isWindows ||
        Platform.isMacOS;
  }

  /// Returns true if the app is running on the web.
  bool get isWeb {
    return kIsWeb;
  }
}
