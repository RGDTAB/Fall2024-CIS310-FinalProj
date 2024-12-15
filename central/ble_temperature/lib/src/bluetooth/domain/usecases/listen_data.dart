import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/data/utils/datablock.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';

class ListenData extends UsecaseStreamWithParams<Datablock, String> {
  ListenData(this._repository);
  final BleRepository _repository;

  @override
  ResultStream<Datablock> call(String params) {
    return _repository.subscribeToCharacteristic(params);
  }
}
