import 'package:ble_temperature/core/app_globals.dart';
import 'package:ble_temperature/core/enums/app_flavor.dart';
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

class InjectionContainer {
  Future<void> init(AppFlavor flavor) async {
    // Permission
    sl
      ..registerFactory(
        () => PermissionsCubit(
          getBluetoothScanStatus: sl(),
          getBluetoothConnectStatus: sl(),
          requestBluetoothConnect: sl(),
          requestBluetoothScan: sl(),
        ),
      )
      ..registerLazySingleton(() => GetPermissionPlatformInfo(sl()))
      ..registerLazySingleton(() => GetBluetoothScanStatus(sl()))
      ..registerLazySingleton(() => GetBluetoothConnectStatus(sl()))
      ..registerLazySingleton(() => RequestBluetoothConnect(sl()))
      ..registerLazySingleton(() => RequestBluetoothScan(sl()))
      ..registerLazySingleton<PermissionsRepository>(
        () => PermissionsRepositoryImpl(sl(), sl()),
      )
      ..registerLazySingleton<PermissionsLocalDataSource>(
        PermissionsLocaDataSourceImpl.new,
      )
      ..registerLazySingleton<DeviceInfoLocalDataSource>(
        DeviceInfoLocalDataSourceImpl.new,
      )

      // BLE
      ..registerFactory(() => InitBleCubit(listenBleState: sl()))
      ..registerFactory(() => ScanCubit(startScan: sl()))
      ..registerFactory(() => LiveCubit(connect: sl(), listenData: sl()))
      ..registerLazySingleton(() => ListenBleState(sl()))
      ..registerLazySingleton(() => StartScan(sl()))
      ..registerLazySingleton(() => Connect(sl()))
      ..registerLazySingleton(() => ListenData(sl()))
      ..registerLazySingleton<BleRepository>(
        () => flavor == AppFlavor.sim
            ? BleRepositoryFake()
            : BleRepositoryImpl(sl()),
      )
      ..registerLazySingleton<BleRemoteDataSource>(
        () => BleRemoteDataSourceImpl(sl()),
      )
      ..registerLazySingleton<FlutterReactiveBle>(FlutterReactiveBle.new)

      // About
      ..registerFactory(() => AboutCubit(loadAppInfo: sl()))
      ..registerLazySingleton(() => LoadAppInfo(sl()))
      ..registerLazySingleton<AppInfoRepository>(
        () => AppInfoRepositoryImpl(sl()),
      )
      ..registerLazySingleton(
        AppInfoLocalDataSourceImpl.new,
      );
  }
}
