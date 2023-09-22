import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:equatable/equatable.dart';

class ScanDictionary extends Equatable {
  const ScanDictionary([this.items = const {}]);
  final Map<String, DiscoveredDevice> items;

  @override
  List<Object?> get props => [items];
}
