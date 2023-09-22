import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:equatable/equatable.dart';

class LivePageParams extends Equatable {
  final DiscoveredDevice device;
  const LivePageParams({
    required this.device,
  });

  @override
  List<Object?> get props => [device];
}
