import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class StartScan extends UsecaseStreamWithParams<DiscoveredDevice, String> {
  final BleRepository _repository;

  StartScan(this._repository);

  @override
  ResultStream<DiscoveredDevice> call(String params) {
    return _repository.scanForDevices(
        withServices: []).where((event) => event.name == params);
  }
}
