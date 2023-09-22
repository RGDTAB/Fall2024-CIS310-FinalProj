import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/bluetooth/data/datasources/ble_remote_data_source.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/characteristic.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/errors/failures.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:dartz/dartz.dart';

class BleRepositoryImpl implements BleRepository {
  final BleRemoteDataSource _remoteDataSource;

  BleRepositoryImpl(this._remoteDataSource);

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
  ResultFuture<void> clearGattCache(String deviceId) async {
    try {
      await _remoteDataSource.clearGattCache(deviceId);
      return right(null);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<DeviceConnectionStateUpdate> connectToAdvertisingDevice(
      {required String deviceId,
      required List<String> withServices,
      required Duration prescanDuration,
      Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
      Duration? connectionTimeout}) {
    return _remoteDataSource.connectToAdvertisingDevice(
        deviceId: deviceId,
        withServices: withServices,
        prescanDuration: prescanDuration);
  }

  @override
  ResultStream<DeviceConnectionStateUpdate> connectToDevice(
      {required String deviceId,
      Map<String, List<String>>? servicesWithCharacteristicsToDiscover,
      Duration? connectionTimeout}) {
    return _remoteDataSource.connectToDevice(deviceId: deviceId);
  }

  @override
  ResultFuture<void> deinitialize() async {
    try {
      await _remoteDataSource.deinitialize();
      return right(null);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<DeviceConnectionStateUpdate> get deviceConnectionStateStream =>
      _remoteDataSource.deviceConnectionStateStream;

  @override
  ResultFuture<void> initialize() async {
    try {
      await _remoteDataSource.initialize();
      return right(null);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<int>> readCharacteristic(
      Characteristic characteristic) async {
    try {
      final result = await _remoteDataSource.readCharacteristic(characteristic);
      return right(result);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<int> requestMtu(
      {required String deviceId, required int mtu}) async {
    try {
      final result =
          await _remoteDataSource.requestMtu(deviceId: deviceId, mtu: mtu);
      return right(result);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<DiscoveredDevice> scanForDevices(
      {required List<String> withServices,
      ScanMode scanMode = ScanMode.balanced,
      bool requireLocationServicesEnabled = true}) {
    return _remoteDataSource.scanForDevices(withServices: withServices);
  }

  @override
  ResultStream<List<int>> subscribeToCharacteristic(
      Characteristic characteristic) {
    return _remoteDataSource.subscribeToCharacteristic(characteristic);
  }

  @override
  ResultFuture<void> writeCharacteristicWithResponse(
      Characteristic characteristic,
      {required List<int> value}) async {
    try {
      await _remoteDataSource.writeCharacteristicWithResponse(characteristic,
          value: value);
      return right(null);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> writeCharacteristicWithoutResponse(
      Characteristic characteristic,
      {required List<int> value}) async {
    try {
      await _remoteDataSource.writeCharacteristicWithoutResponse(characteristic,
          value: value);
      return right(null);
    } on Exception catch (e) {
      return left(BluetoothFailure(message: e.toString()));
    }
  }
}
