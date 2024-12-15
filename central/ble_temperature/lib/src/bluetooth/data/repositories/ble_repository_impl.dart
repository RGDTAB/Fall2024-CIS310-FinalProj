import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/bluetooth/data/datasources/ble_remote_data_source.dart';
import 'package:ble_temperature/src/bluetooth/data/utils/datablock.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/errors/failures.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:dartz/dartz.dart';

class BleRepositoryImpl implements BleRepository {
  BleRepositoryImpl(this._remoteDataSource);
  final BleRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<BLEState> bleState() async {
    try {
      final result = _remoteDataSource.bleState();
      return Future.value(right(result));
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<BLEState> bleStateStream() {
    return _remoteDataSource.bleStateStream();
  }

  @override
  ResultStream<DeviceConnectionStateUpdate> connectToDevice({
    required String deviceId,
    Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
    Duration? connectionTimeout,
  }) {
    return _remoteDataSource.connectToDevice(deviceId: deviceId);
  }

  @override
  ResultStream<DiscoveredDevice> scanForDevices() {
    return _remoteDataSource.scanForDevices();
  }

  @override
  ResultStream<Datablock> subscribeToCharacteristic(String deviceId) {
    return _remoteDataSource.subscribeToCharacteristic(deviceId);
  }
}
