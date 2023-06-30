import 'package:domain/domain.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'ble_start_scan_test.mocks.dart';

@GenerateMocks([BleFacade])
void main() {
  group('use case connect', () {
    final mockBle = MockBleFacade();

    setUpAll(() {});

    test('emits connected', () async {
      when(mockBle.connectToDevice(deviceId: anyNamed('deviceId')))
          .thenAnswer((realInvocation) => Stream.fromIterable([
                DeviceConnectionStateUpdate(
                    deviceConnectionState: DeviceConnectionState.connected,
                    deviceId: '0',
                    error: null)
              ]));

      final r = await BleConnect(mockBle).call(BleConnectParams(id: '0'));

      final sOrNull = r.fold((l) => null, (r) => r);

      sOrNull?.listen(
        expectAsync1<void, DeviceConnectionStateUpdate>(
          (event) {
            expect(
                event,
                DeviceConnectionStateUpdate(
                    deviceId: '0',
                    deviceConnectionState: DeviceConnectionState.connected));
          },
        ),
      );
    });
  });
}
