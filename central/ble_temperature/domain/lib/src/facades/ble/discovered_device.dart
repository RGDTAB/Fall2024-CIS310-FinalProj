import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class DiscoveredDevice extends Equatable {
  /// The unique identifier of the device.
  final String id;
  final String name;

  final Map<String, Uint8List> serviceData;

  /// Advertised services

  final List<String> serviceUuids;

  /// Manufacturer specific data. The first 2 bytes are the Company Identifier Codes.

  final Uint8List manufacturerData;

  final int rssi;

  const DiscoveredDevice({
    required this.id,
    required this.name,
    required this.serviceData,
    required this.manufacturerData,
    required this.rssi,
    required this.serviceUuids,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        serviceData,
        serviceUuids,
        manufacturerData,
        rssi,
      ];
}
