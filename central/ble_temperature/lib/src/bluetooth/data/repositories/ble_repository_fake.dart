import 'dart:convert';
import 'dart:typed_data';

import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/characteristic.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:dartz/dartz.dart';

class BleRepositoryFake implements BleRepository {
  @override
  ResultStream<DeviceConnectionStateUpdate> get deviceConnectionStateStream =>
      Stream.fromIterable([
        const DeviceConnectionStateUpdate(
            deviceId: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
            deviceConnectionState: DeviceConnectionState.connected)
      ]);

  @override
  ResultStream<List<int>> subscribeToCharacteristic(
      Characteristic characteristic) {
    return Stream.periodic(const Duration(seconds: 1),
        (i) => const Utf8Encoder().convert((i % 50).toString()));
  }

  @override
  ResultFuture<List<int>> readCharacteristic(
      Characteristic characteristic) async {
    return Future.value(right([]));
  }

  @override
  ResultFuture<void> writeCharacteristicWithResponse(
      Characteristic characteristic,
      {required List<int> value}) async {
    return Future.value(right(null));
  }

  @override
  ResultFuture<void> writeCharacteristicWithoutResponse(
      Characteristic characteristic,
      {required List<int> value}) async {
    return Future.value(right(null));
  }

  @override
  ResultFuture<void> clearGattCache(String deviceId) async {
    return Future.value(right(null));
  }

  @override
  ResultFuture<void> initialize() async {
    return Future.value(right(null));
  }

  @override
  ResultFuture<void> deinitialize() async {
    return Future.value(right(null));
  }

  @override
  ResultFuture<int> requestMtu(
      {required String deviceId, required int mtu}) async {
    return Future.value(right(23));
  }

  @override
  ResultStream<DiscoveredDevice> scanForDevices({
    required List<String> withServices,
    ScanMode scanMode = ScanMode.balanced,
    bool requireLocationServicesEnabled = true,
  }) {
    return Stream.periodic(
        const Duration(milliseconds: 500),
        (i) => DiscoveredDevice(
            id: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
            name: 'BLE-TEMP',
            serviceData: const {},
            manufacturerData: Uint8List(0),
            rssi: i % 3 == 0 ? -30 : -34,
            serviceUuids: const []));
  }

  @override
  ResultStream<BLEState> bleStateStream() {
    return Stream.fromIterable([BLEState.ready]);
  }

  @override
  ResultFuture<BLEState> bleState() {
    return Future.value(right(BLEState.ready));
  }

  @override
  ResultStream<DeviceConnectionStateUpdate> connectToAdvertisingDevice({
    required String deviceId,
    required List<String> withServices,
    required Duration prescanDuration,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  }) {
    return Stream.fromIterable([
      const DeviceConnectionStateUpdate(
        deviceId: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
        deviceConnectionState: DeviceConnectionState.connected,
      ),
    ]);
  }

  @override
  Stream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  }) {
    return Stream.fromIterable([
      const DeviceConnectionStateUpdate(
          deviceId: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
          deviceConnectionState: DeviceConnectionState.connected,
          error: null),
    ]);
  }
}
