import 'package:flutter/material.dart';

import '../presentation/pages/about/about_page.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/init_ble/init_ble_page.dart';
import '../presentation/pages/live/live_page.dart';
import '../presentation/pages/permissions/permissions_page.dart';
import '../presentation/pages/permissions_legacy/permissions_legacy_page.dart';
import '../presentation/pages/scan/scan_page.dart';

class Routes {
  static const String permissionsPage = 'permissions_page';
  static const String permissionsLegacyPage = 'permissions_legacy_page';
  static const String bleInitPage = 'ble_init_page';
  static const String scanPage = 'scan_page';
  static const String livePage = 'live_page';
  static const String aboutPage = 'about_page';
}

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.permissionsPage:
        return MaterialPageRoute(
          builder: (_) => const PermissionsPage(),
        );
      case Routes.permissionsLegacyPage:
        return MaterialPageRoute(
          builder: (_) => const PermissionsLegacyPage(),
        );
      case Routes.bleInitPage:
        return MaterialPageRoute(
          builder: (_) => const InitBlePage(),
        );
      case Routes.scanPage:
        return MaterialPageRoute(
          builder: (_) => const ScanPage(),
        );
      case Routes.livePage:
        final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => LivePage(
            device: args[0],
          ),
        );
      case Routes.aboutPage:
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => ErrorPage(
            param: settings,
          ),
        );
    }
  }
}
