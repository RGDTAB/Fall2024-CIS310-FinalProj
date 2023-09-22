import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:equatable/equatable.dart';

class ScanDictionary extends Equatable {
  final Map<String, DiscoveredDevice> items;

  const ScanDictionary([this.items = const {}]);

  @override
  List<Object?> get props => [items];
}
