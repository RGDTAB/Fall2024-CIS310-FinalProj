import 'package:equatable/equatable.dart';

class Characteristic extends Equatable {
  const Characteristic({
    required this.characteristicId,
    required this.serviceId,
    required this.deviceId,
  });

  /// Unique uuid of the specific characteristic
  final String characteristicId;

  /// Service uuid of the characteristic
  final String serviceId;

  /// Device id of the BLE device
  final String deviceId;

  @override
  List<Object?> get props => [characteristicId, serviceId, deviceId];
}
