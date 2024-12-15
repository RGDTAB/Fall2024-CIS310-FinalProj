import 'package:ble_temperature/core/app_globals.dart';
import 'package:ble_temperature/core/enums/app_flavor.dart';
import 'package:ble_temperature/core/services/injection_service.dart';
import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_permission_platform_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await InjectionContainer().init(customAppFlavor);
  var initialRoute = Routes.scanPage;

  if (customAppFlavor != AppFlavor.sim) {
    final getPermissionPlatformInfo = sl<GetPermissionPlatformInfo>();
    final result = await getPermissionPlatformInfo();
    initialRoute = result.fold((l) => Routes.errorPage, (r) {
      switch (r) {
        case PermissionPlatformInfo.granted:
          return Routes.bleInitPage;
        case PermissionPlatformInfo.notGranted:
          return Routes.permissionsPage;
        case PermissionPlatformInfo.legacyNotGranted:
          return Routes.permissionsLegacyPage;
      }
    });
  }

  runApp(
    MyApp(
      initialRoute: initialRoute,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.initialRoute, super.key});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: customAppFlavor == AppFlavor.sim ?
            Colors.blue
            : const Color.fromARGB(255, 102, 87, 111),
          brightness: Brightness.dark,
        ),
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
