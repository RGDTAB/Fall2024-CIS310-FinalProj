import 'package:ble_temperature/src/bluetooth/data/utils/extensions.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/characteristic.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as ble;

abstract class BleRemoteDataSource {
  Stream<DeviceConnectionStateUpdate> get deviceConnectionStateStream;
  Stream<List<int>> subscribeToCharacteristic(Characteristic characteristic);
  Future<List<int>> readCharacteristic(Characteristic characteristic);
  Future<void> writeCharacteristicWithResponse(Characteristic characteristic,
      {required List<int> value});
  Future<void> writeCharacteristicWithoutResponse(Characteristic characteristic,
      {required List<int> value});
  Future<void> clearGattCache(String deviceId);
  Future<void> initialize();
  Future<void> deinitialize();
  Future<int> requestMtu({required String deviceId, required int mtu});
  Stream<DiscoveredDevice> scanForDevices({
    required List<String> withServices,
    ScanMode scanMode = ScanMode.balanced,
    bool requireLocationServicesEnabled = true,
  });
  Stream<BLEState> bleStateStream();
  BLEState bleState();
  Stream<DeviceConnectionStateUpdate> connectToAdvertisingDevice({
    required String deviceId,
    required List<String> withServices,
    required Duration prescanDuration,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  });
  Stream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  });
}

class BleRemoteDataSourceImpl implements BleRemoteDataSource {
  final ble.FlutterReactiveBle _ble;

  BleRemoteDataSourceImpl(this._ble);

  @override
  Stream<DeviceConnectionStateUpdate> get deviceConnectionStateStream =>
      _ble.connectedDeviceStream.map((event) => DeviceConnectionStateUpdate(
            deviceId: event.deviceId,
            deviceConnectionState:
                event.connectionState.toDeviceConnectionState(),
            error: event.failure,
          ));

  @override
  Stream<List<int>> subscribeToCharacteristic(Characteristic characteristic) {
    return _ble.subscribeToCharacteristic(ble.QualifiedCharacteristic(
        characteristicId: characteristic.characteristicId.toUuid(),
        serviceId: characteristic.serviceId.toUuid(),
        deviceId: characteristic.deviceId));
  }

  @override
  Future<List<int>> readCharacteristic(Characteristic characteristic) async {
    return await _ble.readCharacteristic(ble.QualifiedCharacteristic(
        characteristicId: characteristic.characteristicId.toUuid(),
        serviceId: characteristic.serviceId.toUuid(),
        deviceId: characteristic.deviceId));
  }

  @override
  Future<void> writeCharacteristicWithResponse(Characteristic characteristic,
      {required List<int> value}) async {
    await _ble.writeCharacteristicWithResponse(
      ble.QualifiedCharacteristic(
          characteristicId: characteristic.characteristicId.toUuid(),
          serviceId: characteristic.serviceId.toUuid(),
          deviceId: characteristic.deviceId),
      value: value,
    );
  }

  @override
  Future<void> writeCharacteristicWithoutResponse(Characteristic characteristic,
      {required List<int> value}) async {
    await _ble.writeCharacteristicWithoutResponse(
      ble.QualifiedCharacteristic(
          characteristicId: characteristic.characteristicId.toUuid(),
          serviceId: characteristic.serviceId.toUuid(),
          deviceId: characteristic.deviceId),
      value: value,
    );
  }

  @override
  Future<void> clearGattCache(String deviceId) async {
    await _ble.clearGattCache(deviceId);
  }

  @override
  Future<void> initialize() async {
    await _ble.initialize();
  }

  @override
  Future<void> deinitialize() async {
    await _ble.deinitialize();
  }

  @override
  Future<int> requestMtu({required String deviceId, required int mtu}) async {
    return await _ble.requestMtu(deviceId: deviceId, mtu: mtu);
  }

  @override
  Stream<DiscoveredDevice> scanForDevices({
    required List<String> withServices,
    ScanMode scanMode = ScanMode.balanced,
    bool requireLocationServicesEnabled = true,
  }) {
    return _ble
        .scanForDevices(
          withServices: withServices.map((e) => e.toUuid()).toList(),
          scanMode: scanMode.toScanBleMode(),
          requireLocationServicesEnabled: requireLocationServicesEnabled,
        )
        .map((event) => DiscoveredDevice(
            id: event.id,
            name: event.name,
            serviceData: {
              for (var item in event.serviceData.entries)
                item.key.toString(): item.value
            },
            manufacturerData: event.manufacturerData,
            rssi: event.rssi,
            serviceUuids:
                event.serviceUuids.map((e) => e.toString()).toList()));
  }

  @override
  Stream<BLEState> bleStateStream() {
    return _ble.statusStream.map((event) => event.toBleStatus());
  }

  @override
  BLEState bleState() {
    return _ble.status.toBleStatus();
  }

  @override
  Stream<DeviceConnectionStateUpdate> connectToAdvertisingDevice({
    required String deviceId,
    required List<String> withServices,
    required Duration prescanDuration,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  }) {
    return _ble
        .connectToAdvertisingDevice(
            id: deviceId,
            withServices: withServices.map((e) => e.toUuid()).toList(),
            prescanDuration: prescanDuration,
            servicesWithCharacteristicsToDiscover:
                servicesWithCharacteristicsToDiscover != null
                    ? {
                        for (var e
                            in servicesWithCharacteristicsToDiscover.entries)
                          e.key.toUuid():
                              e.value.map((e) => e.toUuid()).toList()
                      }
                    : null,
            connectionTimeout: connectionTimeout)
        .map((event) => DeviceConnectionStateUpdate(
              deviceId: event.deviceId,
              deviceConnectionState:
                  event.connectionState.toDeviceConnectionState(),
              error: event.failure,
            ));
  }

  @override
  Stream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  }) {
    return _ble
        .connectToDevice(
          id: deviceId,
          servicesWithCharacteristicsToDiscover:
              servicesWithCharacteristicsToDiscover != null
                  ? {
                      for (var e
                          in servicesWithCharacteristicsToDiscover.entries)
                        e.key.toUuid(): e.value.map((e) => e.toUuid()).toList()
                    }
                  : null,
          connectionTimeout: connectionTimeout,
        )
        .map((event) => DeviceConnectionStateUpdate(
              deviceId: event.deviceId,
              deviceConnectionState:
                  event.connectionState.toDeviceConnectionState(),
              error: event.failure,
            ));
  }
}
