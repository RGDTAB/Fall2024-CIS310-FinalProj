import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:equatable/equatable.dart';

class DeviceConnectionStateUpdate extends Equatable {
  const DeviceConnectionStateUpdate({
    required this.deviceId,
    required this.deviceConnectionState,
    this.error,
  });
  final String deviceId;
  final DeviceConnectionState deviceConnectionState;
  final Object? error;

  @override
  List<Object?> get props => [
        deviceId,
        deviceConnectionState,
        error,
      ];
}
