import 'dart:convert';

import 'package:ble_temperature/src/bluetooth/data/constants/constants.dart';
import 'package:ble_temperature/src/bluetooth/data/datasources/ble_remote_data_source.dart';
import 'package:ble_temperature/src/bluetooth/data/utils/extensions.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
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

  test('[BleRemoteDataSource.statusStream] emits [BleStatus.ready]', () {
    when(ble.statusStream)
        .thenAnswer((_) => Stream.value(reactive_ble.BleStatus.ready));
    expect(dataSource.bleStateStream(), emits(BLEState.ready));
    verify(ble.statusStream).called(1);
    verifyNoMoreInteractions(ble);
  });

  test(
      '[BleRemoteDataSource.connectToDevice] emits '
      '[DeviceConnectionStateUpdate()]', () {
    when(ble.connectToDevice(id: anyNamed('id'))).thenAnswer(
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

  test('[BleRemoteDataSource.subscribeToCharacteristic] emits 0.0', () {
    when(ble.subscribeToCharacteristic(any)).thenAnswer(
      (_) => Stream.value(const Utf8Encoder().convert('0')),
    );

    expect(
      dataSource.subscribeToCharacteristic(''),
      emits(0.0),
    );
    verify(
      ble.subscribeToCharacteristic(
        reactive_ble.QualifiedCharacteristic(
          characteristicId: kChrUuid.toUuid(),
          serviceId: kSrvUuid.toUuid(),
          deviceId: '',
        ),
      ),
    ).called(1);
    verifyNoMoreInteractions(ble);
  });
}
