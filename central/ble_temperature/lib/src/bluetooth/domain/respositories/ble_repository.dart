import 'package:ble_temperature/core/typedefs/typedefs.dart';

import '../entities/characteristic.dart';
import '../entities/device_connection_state_update.dart';
import '../entities/discovered_device.dart';
import '../enums/enums.dart';

abstract class BleRepository {
  ResultStream<DeviceConnectionStateUpdate> get deviceConnectionStateStream;

  ResultStream<List<int>> subscribeToCharacteristic(
      Characteristic characteristic);

  ResultFuture<List<int>> readCharacteristic(Characteristic characteristic);

  ResultFuture<void> writeCharacteristicWithResponse(
      Characteristic characteristic,
      {required List<int> value});

  ResultFuture<void> writeCharacteristicWithoutResponse(
      Characteristic characteristic,
      {required List<int> value});

  ResultFuture<void> clearGattCache(String deviceId);

  ResultFuture<void> initialize();

  ResultFuture<void> deinitialize();

  ResultFuture<int> requestMtu({required String deviceId, required int mtu});

  ResultStream<DiscoveredDevice> scanForDevices({
    required List<String> withServices,
    ScanMode scanMode = ScanMode.balanced,
    bool requireLocationServicesEnabled = true,
  });

  ResultStream<BLEState> bleStateStream();

  ResultFuture<BLEState> bleState();

  ResultStream<DeviceConnectionStateUpdate> connectToAdvertisingDevice({
    required String deviceId,
    required List<String> withServices,
    required Duration prescanDuration,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  });

  ResultStream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  });
}
