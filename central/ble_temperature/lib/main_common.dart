import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/app_flavor.dart';
import 'config/app_routes.dart';
import 'generated/l10n.dart';
import 'globals.dart';
import 'injection_container.dart';
import 'presentation/pages/error/error_page.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await InjectionContainer().init(appFlavor);
  var initialRoute = Routes.scanPage;

  if (appFlavor != AppFlavor.sim) {
    final result = await getIt<PermissionsCheck>().call(const NoParams());
    initialRoute = result.fold((l) => Routes.errorPage, (r) {
      if (r.hasAllPermissions) {
        return Routes.bleInitPage;
      } else if (r.isLegacy ?? false) {
        return Routes.permissionsLegacyPage;
      } else {
        return Routes.permissionsPage;
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
