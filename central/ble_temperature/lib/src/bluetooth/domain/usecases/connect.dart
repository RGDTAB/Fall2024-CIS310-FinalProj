import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:equatable/equatable.dart';

class Connect extends UsecaseStreamWithParams<DeviceConnectionStateUpdate,
    ConnectParams> {
  Connect(this._repository);
  final BleRepository _repository;

  @override
  ResultStream<DeviceConnectionStateUpdate> call(ConnectParams params) {
    return _repository.connectToDevice(
      deviceId: params.deviceId,
      connectionTimeout: params.timeout,
    );
  }
}

class ConnectParams extends Equatable {
  const ConnectParams({required this.deviceId, required this.timeout});
  final String deviceId;
  final Duration timeout;

  @override
  List<Object?> get props => [deviceId, timeout];
}
