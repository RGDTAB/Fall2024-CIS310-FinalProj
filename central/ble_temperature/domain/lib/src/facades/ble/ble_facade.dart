import 'characteristic.dart';
import 'device_connection_state_update.dart';
import 'discovered_device.dart';
import 'enums.dart';

abstract class BleFacade {
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
