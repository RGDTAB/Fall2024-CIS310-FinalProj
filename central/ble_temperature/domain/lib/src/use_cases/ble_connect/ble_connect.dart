import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain.dart';
import '../../core/use_case/failure.dart';

part 'ble_connect.freezed.dart';

class BleConnect
    implements UseCase<Stream<DeviceConnectionStateUpdate>, BleConnectParams> {
  final BleFacade _bleFacade;

  BleConnect(this._bleFacade);

  @override
  Future<Either<Failure, Stream<DeviceConnectionStateUpdate>>> call(
      BleConnectParams params) {
    final x = _bleFacade.connectToDevice(
        deviceId: params.id, connectionTimeout: Duration(seconds: 5));
    return Future.value(right(x));
  }
}

@freezed
class BleConnectParams with _$BleConnectParams {
  factory BleConnectParams({
    required String id,
  }) = _BleConnectParams;
}
