import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';

class ListenBleState extends UsecaseStreamWithoutParams<BLEState> {
  ListenBleState(this._repository);
  final BleRepository _repository;

  @override
  ResultStream<BLEState> call() {
    return _repository.bleStateStream();
  }
}
