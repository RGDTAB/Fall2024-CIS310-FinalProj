import 'package:ble_temperature/src/bluetooth/data/datasources/ble_remote_data_source.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as reactive_ble;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<reactive_ble.FlutterReactiveBle>()])
import 'ble_remote_data_source_test.mocks.dart';

void main() {
  late MockFlutterReactiveBle ble;
  late BleRemoteDataSource dataSource;

  setUp(() {
    ble = MockFlutterReactiveBle();
    dataSource = BleRemoteDataSourceImpl(ble);
  });

  test('Ble state stream emits BleStatus.ready', () {
    when(ble.statusStream)
        .thenAnswer((_) => Stream.value(reactive_ble.BleStatus.ready));
    expect(dataSource.bleStateStream(), emits(BLEState.ready));
    verify(ble.statusStream).called(1);
    verifyNoMoreInteractions(ble);
  });

  test('Ble state stream emits BleStatus.ready', () {
    when(ble.connectToDevice(id: '')).thenAnswer(
      (_) => Stream.fromIterable([
        const reactive_ble.ConnectionStateUpdate(
          connectionState: reactive_ble.DeviceConnectionState.connected,
          deviceId: '',
          failure: null,
        ),
      ]),
    );

    expect(
      dataSource.connectToDevice(deviceId: ''),
      emits(
        const DeviceConnectionStateUpdate(
          deviceId: '',
          deviceConnectionState: DeviceConnectionState.connected,
        ),
      ),
    );
    verify(ble.connectToDevice(id: '')).called(1);
    verifyNoMoreInteractions(ble);
  });
}
