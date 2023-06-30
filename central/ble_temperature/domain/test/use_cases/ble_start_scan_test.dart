import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'ble_start_scan_test.mocks.dart';

@GenerateMocks([BleFacade])
void main() {
  group('use case scan', () {
    final mockBle = MockBleFacade();

    setUpAll(() {});

    test('emits scan', () async {
      when(mockBle.scanForDevices(withServices: anyNamed('withServices')))
          .thenAnswer((invocation) => Stream<DiscoveredDevice>.fromIterable([
                DiscoveredDevice(
                    id: 'id',
                    name: 'HC-08',
                    serviceData: {},
                    manufacturerData: Uint8List(0),
                    rssi: -50,
                    serviceUuids: []),
              ]));

      final r =
          await BleStartScan(mockBle).call(BleStartScanParams(name: 'HC-08'));

      final sOrNull = r.fold((l) => null, (r) => r);

      sOrNull?.listen(
        expectAsync1<void, DiscoveredDevice>(
          (event) {
            expect(
                event,
                DiscoveredDevice(
                    id: 'id',
                    name: 'HC-08',
                    serviceData: {},
                    manufacturerData: Uint8List(0),
                    rssi: -50,
                    serviceUuids: []));
          },
        ),
      );
    });

    test('emits multiple scans', () async {
      when(mockBle.scanForDevices(withServices: []))
          .thenAnswer((invocation) => Stream<DiscoveredDevice>.fromIterable([
                DiscoveredDevice(
                    id: 'id',
                    name: '_',
                    serviceData: {},
                    manufacturerData: Uint8List(0),
                    rssi: -50,
                    serviceUuids: []),
                DiscoveredDevice(
                    id: 'id',
                    name: 'HC-08',
                    serviceData: {},
                    manufacturerData: Uint8List(0),
                    rssi: -50,
                    serviceUuids: [])
              ]));

      final r =
          await BleStartScan(mockBle).call(BleStartScanParams(name: 'HC-08'));

      final sOrNull = r.fold((l) => null, (r) => r);

      expectLater(
          sOrNull,
          emitsInOrder([
            DiscoveredDevice(
                id: 'id',
                name: 'HC-08',
                serviceData: {},
                manufacturerData: Uint8List(0),
                rssi: -50,
                serviceUuids: [])
          ]));
    });
  });
}
