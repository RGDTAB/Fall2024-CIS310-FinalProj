import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';

class StartScan extends UsecaseStreamWithParams<DiscoveredDevice, String> {
  StartScan(this._repository);
  final BleRepository _repository;

  @override
  ResultStream<DiscoveredDevice> call(String params) {
    return _repository.scanForDevices();
  }
}
