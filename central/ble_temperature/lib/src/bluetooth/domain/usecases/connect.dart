import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/typedefs/typedefs.dart';

class Connect extends UsecaseStreamWithParams<DeviceConnectionStateUpdate,
    ConnectParams> {
  final BleRepository _repository;

  Connect(this._repository);

  @override
  ResultStream<DeviceConnectionStateUpdate> call(ConnectParams params) {
    return _repository.connectToDevice(
        deviceId: params.deviceId, connectionTimeout: params.timeout);
  }
}

class ConnectParams extends Equatable {
  final String deviceId;
  final Duration timeout;

  const ConnectParams({required this.deviceId, required this.timeout});

  @override
  List<Object?> get props => [deviceId, timeout];
}
