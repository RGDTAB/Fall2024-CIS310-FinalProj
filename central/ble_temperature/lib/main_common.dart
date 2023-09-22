import 'package:ble_temperature/core/app_flavor.dart';
import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_permission_platform_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'core/globals.dart';
import 'core/services/injection_service.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await InjectionContainer().init(appFlavor);
  var initialRoute = Routes.scanPage;

  if (appFlavor != AppFlavor.sim) {
    final getPermissionPlatformInfo = sl<GetPermissionPlatformInfo>();
    final result = await getPermissionPlatformInfo();
    initialRoute = result.fold((l) => Routes.errorPage, (r) {
      switch (r) {
        case PermissionPlatformInfo.granted:
          return Routes.bleInitPage;
        case PermissionPlatformInfo.notGranted:
          return Routes.permissionsPage;
        default:
          return Routes.permissionsLegacyPage;
      }
    });
  }

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: appFlavor == AppFlavor.sim ? Colors.blue : Colors.red),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
