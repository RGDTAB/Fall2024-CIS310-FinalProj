import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('add item', () {
    late final DiscoveredDevice d1;
    late final DiscoveredDevice d2;

    setUpAll(() {
      d1 = DiscoveredDevice(
          id: '1',
          name: 'device_1',
          serviceData: {},
          manufacturerData: Uint8List(0),
          rssi: -50,
          serviceUuids: []);

      d2 = DiscoveredDevice(
          id: '2',
          name: 'device_2',
          serviceData: {},
          manufacturerData: Uint8List(0),
          rssi: -50,
          serviceUuids: []);
    });

    test('empty scans - add item', () {
      final scans = const ScanDictionary().addItem(d1);
      expect(scans.items, {d1.id: d1});
    });

    test('empty scans - add two items', () {
      final scans = const ScanDictionary().addItem(d1).addItem(d2);
      expect(scans.items, {
        d1.id: d1,
        d2.id: d2,
      });
    });

    test('empty scans - add same item twice', () {
      final scans = const ScanDictionary().addItem(d1).addItem(d1);
      expect(scans.items, {d1.id: d1});
    });
  });
}
