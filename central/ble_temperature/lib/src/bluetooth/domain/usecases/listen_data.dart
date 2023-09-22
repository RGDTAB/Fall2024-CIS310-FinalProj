import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/characteristic.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/typedefs/typedefs.dart';

class ListenData extends UsecaseStreamWithParams<List<int>, ListenDataParams> {
  final BleRepository _repository;

  ListenData(this._repository);

  @override
  ResultStream<List<int>> call(ListenDataParams params) {
    final chr = Characteristic(
        characteristicId: params.characteristicUuid,
        serviceId: params.serviceUuid,
        deviceId: params.deviceId);

    return _repository.subscribeToCharacteristic(chr);
    // TODO: parse data layer!
    // return Future.value(right(_bleFacade
    //     .subscribeToCharacteristic(chr)
    //     .map((event) => double.parse(Utf8Decoder().convert(event)))));
  }
}

class ListenDataParams extends Equatable {
  final String deviceId;
  final String characteristicUuid;
  final String serviceUuid;

  const ListenDataParams(
      {required this.deviceId,
      required this.characteristicUuid,
      required this.serviceUuid});

  @override
  List<Object?> get props => [deviceId, characteristicUuid, serviceUuid];
}
