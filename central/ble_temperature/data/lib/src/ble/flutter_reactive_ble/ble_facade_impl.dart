import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as ble;

import 'ble_state_adapter.dart';
import 'device_connection_state_adapter.dart';
import 'scan_mode_adapter.dart';
import 'uuid_adapter.dart';

class BleFacadeImpl implements BleFacade {
  final ble.FlutterReactiveBle _ble = ble.FlutterReactiveBle();

  @override
  Stream<DeviceConnectionStateUpdate> get deviceConnectionStateStream =>
      _ble.connectedDeviceStream.map((event) => DeviceConnectionStateUpdate(
            deviceId: event.deviceId,
            deviceConnectionState:
                DeviceConnectionStateAdapter().fromExt(event.connectionState),
            error: event.failure,
          ));

  @override
  Stream<List<int>> subscribeToCharacteristic(Characteristic characteristic) {
    return _ble.subscribeToCharacteristic(ble.QualifiedCharacteristic(
        characteristicId: UUIDAdapter().toExt(characteristic.characteristicId),
        serviceId: UUIDAdapter().toExt(characteristic.serviceId),
        deviceId: characteristic.deviceId));
  }

  @override
  Future<List<int>> readCharacteristic(Characteristic characteristic) async {
    return await _ble.readCharacteristic(ble.QualifiedCharacteristic(
        characteristicId: UUIDAdapter().toExt(characteristic.characteristicId),
        serviceId: UUIDAdapter().toExt(characteristic.serviceId),
        deviceId: characteristic.deviceId));
  }

  @override
  Future<void> writeCharacteristicWithResponse(Characteristic characteristic,
      {required List<int> value}) async {
    await _ble.writeCharacteristicWithResponse(
      ble.QualifiedCharacteristic(
          characteristicId:
              UUIDAdapter().toExt(characteristic.characteristicId),
          serviceId: UUIDAdapter().toExt(characteristic.serviceId),
          deviceId: characteristic.deviceId),
      value: value,
    );
  }

  @override
  Future<void> writeCharacteristicWithoutResponse(Characteristic characteristic,
      {required List<int> value}) async {
    await _ble.writeCharacteristicWithoutResponse(
      ble.QualifiedCharacteristic(
          characteristicId:
              UUIDAdapter().toExt(characteristic.characteristicId),
          serviceId: UUIDAdapter().toExt(characteristic.serviceId),
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
          withServices:
              withServices.map((e) => UUIDAdapter().toExt(e)).toList(),
          scanMode: ScanModeAdapter().toExt(scanMode),
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
            serviceUuids: event.serviceUuids
                .map((e) => UUIDAdapter().fromExt(e))
                .toList()));
  }

  @override
  Stream<BLEState> bleStateStream() {
    return _ble.statusStream.map((event) => BLEStateAdapter().fromExt(event));
  }

  @override
  BLEState bleState() {
    return BLEStateAdapter().fromExt(_ble.status);
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
            withServices:
                withServices.map((e) => UUIDAdapter().toExt(e)).toList(),
            prescanDuration: prescanDuration,
            servicesWithCharacteristicsToDiscover:
                servicesWithCharacteristicsToDiscover != null
                    ? {
                        for (var e
                            in servicesWithCharacteristicsToDiscover.entries)
                          UUIDAdapter().toExt(e.key): e.value
                              .map((e) => UUIDAdapter().toExt(e))
                              .toList()
                      }
                    : null,
            connectionTimeout: connectionTimeout)
        .map((event) => DeviceConnectionStateUpdate(
              deviceId: event.deviceId,
              deviceConnectionState:
                  DeviceConnectionStateAdapter().fromExt(event.connectionState),
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
                        UUIDAdapter().toExt(e.key):
                            e.value.map((e) => UUIDAdapter().toExt(e)).toList()
                    }
                  : null,
          connectionTimeout: connectionTimeout,
        )
        .map((event) => DeviceConnectionStateUpdate(
              deviceId: event.deviceId,
              deviceConnectionState:
                  DeviceConnectionStateAdapter().fromExt(event.connectionState),
              error: event.failure,
            ));
  }
}
