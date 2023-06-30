import 'package:equatable/equatable.dart';

import 'enums.dart';

class DeviceConnectionStateUpdate extends Equatable {
  final String deviceId;
  final DeviceConnectionState deviceConnectionState;
  final Object? error;

  const DeviceConnectionStateUpdate({
    required this.deviceId,
    required this.deviceConnectionState,
    this.error,
  });

  @override
  List<Object?> get props => [
        deviceId,
        deviceConnectionState,
        error,
      ];
}
