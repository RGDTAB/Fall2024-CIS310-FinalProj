import 'package:ble_temperature/core/globals.dart';
import 'package:ble_temperature/src/about/data/datasources/app_info_impl.dart';
import 'package:ble_temperature/src/about/data/repositories/app_info_repository_impl.dart';
import 'package:ble_temperature/src/about/domain/repositories/app_info_repository.dart';
import 'package:ble_temperature/src/about/domain/usecases/load_app_info.dart';
import 'package:ble_temperature/src/about/presentation/cubit/about_cubit.dart';
import 'package:ble_temperature/src/bluetooth/data/datasources/ble_remote_data_source.dart';
import 'package:ble_temperature/src/bluetooth/data/repositories/ble_repository_fake.dart';
import 'package:ble_temperature/src/bluetooth/data/repositories/ble_repository_impl.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/connect.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/listen_ble_state.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/listen_data.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/start_scan.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/init_ble/init_ble_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/live/live_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/scan/scan_cubit.dart';
import 'package:ble_temperature/src/device_information/data/datasources/device_info_local_datasource.dart';
import 'package:ble_temperature/src/permissions/data/datasources/permissions_data_source.dart';
import 'package:ble_temperature/src/permissions/data/repositories/permissions_repository_impl.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_bluetooth_connect_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_bluetooth_scan_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/request_bluetooth_connect.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/request_bluetooth_scan.dart';
import 'package:ble_temperature/src/permissions/presentation/cubit/permissions/permissions_cubit.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../app_flavor.dart';

class InjectionContainer {
  Future<void> init(AppFlavor flavor) async {
    // Permission
    sl.registerFactory(() => PermissionsCubit(
          getBluetoothScanStatus: sl(),
          getBluetoothConnectStatus: sl(),
          requestBluetoothConnect: sl(),
          requestBluetoothScan: sl(),
        ));

    sl.registerLazySingleton(() => GetPermissionPlatformInfo(sl()));
    sl.registerLazySingleton(() => GetBluetoothScanStatus(sl()));
    sl.registerLazySingleton(() => GetBluetoothConnectStatus(sl()));
    sl.registerLazySingleton(() => RequestBluetoothConnect(sl()));
    sl.registerLazySingleton(() => RequestBluetoothScan(sl()));
    sl.registerLazySingleton<PermissionsRepository>(
        () => PermissionsRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<PermissionsLocalDataSource>(
        () => PermissionsLocaDataSourceImpl());
    sl.registerLazySingleton<DeviceInfoLocalDataSource>(
        () => DeviceInfoLocalDataSourceImpl());

    // BLE
    sl.registerFactory(() => InitBleCubit(listenBleState: sl()));
    sl.registerFactory(() => ScanCubit(startScan: sl()));
    sl.registerFactory(() => LiveCubit(connect: sl(), listenData: sl()));
    sl.registerLazySingleton(() => ListenBleState(sl()));
    sl.registerLazySingleton(() => StartScan(sl()));
    sl.registerLazySingleton(() => Connect(sl()));
    sl.registerLazySingleton(() => ListenData(sl()));
    sl.registerLazySingleton<BleRepository>(() => flavor == AppFlavor.sim
        ? BleRepositoryFake()
        : BleRepositoryImpl(sl()));
    sl.registerLazySingleton<BleRemoteDataSource>(
        () => BleRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton<FlutterReactiveBle>(() => FlutterReactiveBle());

    // About
    sl.registerFactory(() => AboutCubit(loadAppInfo: sl()));
    sl.registerLazySingleton(() => LoadAppInfo(sl()));
    sl.registerLazySingleton<AppInfoRepository>(
        () => AppInfoRepositoryImpl(sl()));
    sl.registerLazySingleton<AppInfoLocalDataSource>(
        () => AppInfoLocalDataSourceImpl());
  }
}
