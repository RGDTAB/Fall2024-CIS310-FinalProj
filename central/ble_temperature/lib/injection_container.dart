import 'package:data/data.dart';
import 'package:domain/domain.dart';

import 'config/app_flavor.dart';
import 'globals.dart';

class InjectionContainer {
  Future<void> init(AppFlavor flavor) async {
    switch (flavor) {
      case AppFlavor.sim:
        // REGISTER REPOS HERE:

        // REGISTER FACADES HERE:
        getIt.registerLazySingleton<BleFacade>(() => BleFake());
        getIt.registerLazySingleton<AppInfoFacade>(() => AppInfoImpl());
        getIt.registerLazySingleton<DeviceInfoFacade>(() => DeviceInfoImpl());

        // REGISTER USE-CASES HERE:
        getIt.registerLazySingleton<PermissionsCheck>(
            () => PermissionsCheck(getIt(), getIt()));
        getIt.registerLazySingleton<BleStartScan>(() => BleStartScan(getIt()));
        getIt.registerLazySingleton<BleConnect>(() => BleConnect(getIt()));
        getIt.registerLazySingleton<BleGetData>(() => BleGetData(getIt()));
        break;
      default:
        // REGISTER REPOS HERE:

        // REGISTER FACADES HERE:
        getIt.registerLazySingleton<PermissionsFacade>(
            () => PermissionsFacadeImpl());
        getIt.registerLazySingleton<BleFacade>(() => BleImpl());
        getIt.registerLazySingleton<AppInfoFacade>(() => AppInfoImpl());
        getIt.registerLazySingleton<DeviceInfoFacade>(() => DeviceInfoImpl());

        // REGISTER USE-CASES HERE:
        getIt.registerLazySingleton<PermissionsCheck>(
            () => PermissionsCheck(getIt(), getIt()));
        getIt.registerLazySingleton<BleStartScan>(() => BleStartScan(getIt()));
        getIt.registerLazySingleton<BleConnect>(() => BleConnect(getIt()));
        getIt.registerLazySingleton<BleGetData>(() => BleGetData(getIt()));
    }
  }
}
