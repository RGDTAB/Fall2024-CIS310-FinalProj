import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain.dart';

part 'ble_get_data.freezed.dart';

class BleGetData
    implements UseCase<NoFailure, Stream<double>, BleGetDataParams> {
  final BleFacade _bleFacade;

  BleGetData(this._bleFacade);

  @override
  Future<Either<NoFailure, Stream<double>>> call(BleGetDataParams params) {
    final chr = Characteristic(
        characteristicId: params.characteristicUuid,
        serviceId: params.serviceUuid,
        deviceId: params.deviceId);

    return Future.value(right(_bleFacade
        .subscribeToCharacteristic(chr)
        .map((event) => double.parse(Utf8Decoder().convert(event)))));
  }
}

@freezed
class BleGetDataParams with _$BleGetDataParams {
  factory BleGetDataParams({
    required String deviceId,
    required String serviceUuid,
    required String characteristicUuid,
  }) = _BleGetDataParams;
}
