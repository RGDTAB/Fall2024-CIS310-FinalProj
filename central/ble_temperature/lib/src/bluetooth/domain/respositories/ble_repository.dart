import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/bluetooth/data/utils/datablock.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';

abstract class BleRepository {
  ResultStream<Datablock> subscribeToCharacteristic(String deviceId);

  ResultStream<DiscoveredDevice> scanForDevices();

  ResultStream<BLEState> bleStateStream();

  ResultFuture<BLEState> bleState();

  ResultStream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  });
}
