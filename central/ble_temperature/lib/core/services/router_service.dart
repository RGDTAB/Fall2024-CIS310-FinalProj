import 'package:ble_temperature/core/app_globals.dart';
import 'package:ble_temperature/core/errors/error_page.dart';
import 'package:ble_temperature/src/about/presentation/cubit/about_cubit.dart';
import 'package:ble_temperature/src/about/presentation/pages/about_page.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/init_ble/init_ble_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/live/live_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/scan/scan_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/init_ble/init_ble_page.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/live/live_page.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/live/live_page_params.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/scan/scan_page.dart';
import 'package:ble_temperature/src/permissions/presentation/cubit/permissions/permissions_cubit.dart';
import 'package:ble_temperature/src/permissions/presentation/cubit/permissions_legacy/permissions_legacy_cubit.dart';
import 'package:ble_temperature/src/permissions/presentation/pages/permissions/permissions_page.dart';
import 'package:ble_temperature/src/permissions/presentation/pages/permissions_legacy/permissions_legacy_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../presentation/pages/permissions/permissions_page.dart';
// import '../presentation/pages/permissions_legacy/permissions_legacy_page.dart';

class Routes {
  static const String permissionsPage = 'permissions_page';
  static const String permissionsLegacyPage = 'permissions_legacy_page';
  static const String bleInitPage = 'ble_init_page';
  static const String scanPage = 'scan_page';
  static const String livePage = 'live_page';
  static const String aboutPage = 'about_page';
  static const String errorPage = 'error_page';
}

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.permissionsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PermissionsCubit>(
            create: (_) => sl(),
            child: const PermissionsPage(),
          ),
          settings: settings,
        );
      case Routes.permissionsLegacyPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PermissionsLegacyCubit>(
            create: (_) => sl(),
            child: const PermissionsLegacyPage(),
          ),
          settings: settings,
        );
      case Routes.bleInitPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<InitBleCubit>(
            create: (_) => sl(),
            child: const InitBlePage(),
          ),
          settings: settings,
        );
      case Routes.scanPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ScanCubit>(
            create: (_) => sl(),
            child: const ScanPage(),
          ),
          settings: settings,
        );
      case Routes.livePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LiveCubit>(
            create: (_) => sl(),
            child: LivePage(
              params: settings.arguments! as LivePageParams,
            ),
          ),
          settings: settings,
        );
      case Routes.aboutPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AboutCubit>(
            create: (_) => sl(),
            child: const AboutPage(),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => ErrorPage(
            param: settings,
          ),
          settings: settings,
        );
    }
  }
}
