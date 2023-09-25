import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/connect.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BleRepository>()])
import 'connect_test.mocks.dart';

void main() {
  late Connect usecase;
  late MockBleRepository repository;

  setUp(() {
    repository = MockBleRepository();
    usecase = Connect(repository);
  });

  test('[Connect] should emit successfully [DeviceConnectionStateUpdate].',
      () async {
    const tUpdate = DeviceConnectionStateUpdate(
      deviceId: '',
      deviceConnectionState: DeviceConnectionState.connected,
    );

    const params = ConnectParams(deviceId: '', timeout: Duration.zero);

    when(
      repository.connectToDevice(
        deviceId: anyNamed('deviceId'),
        connectionTimeout: anyNamed('connectionTimeout'),
      ),
    ).thenAnswer((_) => Stream.value(tUpdate));

    final result = usecase(params);

    expect(
      result,
      emits(
        const DeviceConnectionStateUpdate(
          deviceId: '',
          deviceConnectionState: DeviceConnectionState.connected,
        ),
      ),
    );
    verify(
      repository.connectToDevice(
        deviceId: '',
        connectionTimeout: Duration.zero,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
