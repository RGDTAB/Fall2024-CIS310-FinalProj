import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:equatable/equatable.dart';

class LivePageParams extends Equatable {
  const LivePageParams({
    required this.device,
  });
  final DiscoveredDevice device;

  @override
  List<Object?> get props => [device];
}
