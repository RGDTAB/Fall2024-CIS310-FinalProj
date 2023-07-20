import 'dart:convert';
import 'dart:typed_data';

import 'package:domain/domain.dart';

class BleFake implements BleFacade {
  @override
  Stream<DeviceConnectionStateUpdate> get deviceConnectionStateStream =>
      Stream.fromIterable([
        DeviceConnectionStateUpdate(
            deviceId: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
            deviceConnectionState: DeviceConnectionState.connected)
      ]);

  @override
  Stream<List<int>> subscribeToCharacteristic(Characteristic characteristic) {
    return Stream.periodic(Duration(seconds: 1),
        (i) => Utf8Encoder().convert((i % 50).toString()));
  }

  @override
  Future<List<int>> readCharacteristic(Characteristic characteristic) async {
    return Future.value([]);
  }

  @override
  Future<void> writeCharacteristicWithResponse(Characteristic characteristic,
      {required List<int> value}) async {
    return Future.value();
  }

  @override
  Future<void> writeCharacteristicWithoutResponse(Characteristic characteristic,
      {required List<int> value}) async {
    return Future.value();
  }

  @override
  Future<void> clearGattCache(String deviceId) async {
    return Future.value();
  }

  @override
  Future<void> initialize() async {
    return Future.value();
  }

  @override
  Future<void> deinitialize() async {
    return Future.value();
  }

  @override
  Future<int> requestMtu({required String deviceId, required int mtu}) async {
    return Future.value(23);
  }

  @override
  Stream<DiscoveredDevice> scanForDevices({
    required List<String> withServices,
    ScanMode scanMode = ScanMode.balanced,
    bool requireLocationServicesEnabled = true,
  }) {
    return Stream.periodic(
        Duration(milliseconds: 500),
        (i) => DiscoveredDevice(
            id: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
            name: 'BLE-TEMP',
            serviceData: {},
            manufacturerData: Uint8List(0),
            rssi: i % 3 == 0 ? -30 : -34,
            serviceUuids: []));
  }

  @override
  Stream<BLEState> bleStateStream() {
    return Stream.fromIterable([BLEState.ready]);
  }

  @override
  BLEState bleState() {
    return BLEState.ready;
  }

  @override
  Stream<DeviceConnectionStateUpdate> connectToAdvertisingDevice({
    required String deviceId,
    required List<String> withServices,
    required Duration prescanDuration,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  }) {
    return Stream.fromIterable([
      DeviceConnectionStateUpdate(
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
      DeviceConnectionStateUpdate(
          deviceId: 'ad677e02-3635-44dc-bf1e-473457fff0d8',
          deviceConnectionState: DeviceConnectionState.connected,
          error: null),
    ]);
  }
}
