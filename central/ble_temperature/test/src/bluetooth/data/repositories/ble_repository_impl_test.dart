import 'dart:typed_data';

import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:ble_temperature/src/bluetooth/data/datasources/ble_remote_data_source.dart';
import 'package:ble_temperature/src/bluetooth/data/repositories/ble_repository_impl.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BleRemoteDataSource>()])
import 'ble_repository_impl_test.mocks.dart';

void main() {
  late MockBleRemoteDataSource dataSource;
  late BleRepositoryImpl repository;

  setUp(() {
    dataSource = MockBleRemoteDataSource();
    repository = BleRepositoryImpl(dataSource);
  });

  test(
      '[AppInfoRepositoryImpl]'
      'should be a subclass of [AppInfoRepository].', () async {
    expect(repository, isA<BleRepository>());
  });

  test('[Repository.bleState] successfully returns [BLEState.ready].',
      () async {
    when(dataSource.bleState()).thenReturn(
      BLEState.ready,
    );

    final result = await repository.bleState();

    expect(
      result,
      const Right<AppInfo, dynamic>(
        BLEState.ready,
      ),
    );
    verify(dataSource.bleState()).called(1);
    verifyNoMoreInteractions(dataSource);
  });

  test(
      '[Repository.connectToDevice] successfully returns '
      '[DeviceConnectionStateUpdate].', () async {
    const tDeviceConnectionStateUpdate = DeviceConnectionStateUpdate(
      deviceId: '',
      deviceConnectionState: DeviceConnectionState.connected,
    );

    when(dataSource.connectToDevice(deviceId: anyNamed('deviceId')))
        .thenAnswer((_) => Stream.value(tDeviceConnectionStateUpdate));

    final result = repository.connectToDevice(deviceId: '');

    expect(result, emits(tDeviceConnectionStateUpdate));
    verify(dataSource.connectToDevice(deviceId: '')).called(1);
    verifyNoMoreInteractions(dataSource);
  });

  test(
      '[Repository.scanForDevices] successfully returns '
      '[DiscoveredDevice].', () async {
    final tDevice = DiscoveredDevice(
      id: '',
      name: '',
      serviceData: const {},
      manufacturerData: Uint8List(0),
      rssi: 0,
      serviceUuids: const [],
    );

    when(dataSource.scanForDevices()).thenAnswer(
      (_) => Stream.value(tDevice),
    );

    final result = repository.scanForDevices();

    expect(result, emits(tDevice));
    verify(dataSource.scanForDevices()).called(1);
    verifyNoMoreInteractions(dataSource);
  });

  test(
      '[Repository.subscribeToCharacteristic] successfully returns '
      '[0.0].', () async {
    when(dataSource.subscribeToCharacteristic(any)).thenAnswer(
      (_) => Stream<double>.value(0),
    );

    final result = repository.subscribeToCharacteristic('');

    expect(result, emits(0.0));
    verify(dataSource.subscribeToCharacteristic('')).called(1);
    verifyNoMoreInteractions(dataSource);
  });
}
