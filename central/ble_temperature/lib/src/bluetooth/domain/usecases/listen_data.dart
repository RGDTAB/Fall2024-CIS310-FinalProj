import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';

class ListenData extends UsecaseStreamWithParams<double, String> {
  ListenData(this._repository);
  final BleRepository _repository;

  @override
  ResultStream<double> call(String params) {
    return _repository.subscribeToCharacteristic(params);
  }
}
