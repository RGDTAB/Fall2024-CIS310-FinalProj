import 'dart:typed_data';

import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:dartz/dartz.dart';

class BleRepositoryFake implements BleRepository {
  @override
  ResultStream<double> subscribeToCharacteristic(String deviceId) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (i) => i % 50,
    );
  }

  @override
  ResultStream<DiscoveredDevice> scanForDevices() {
    return Stream.periodic(
      const Duration(milliseconds: 500),
      (i) => DiscoveredDevice(
        id: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
        name: 'BLE-TEMP',
        serviceData: const {},
        manufacturerData: Uint8List(0),
        rssi: i % 3 == 0 ? -30 : -34,
        serviceUuids: const [],
      ),
    );
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
  Stream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
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
}
