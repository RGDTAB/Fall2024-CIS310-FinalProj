import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/respositories/ble_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class ListenBleState extends UsecaseStreamWithoutParams<BLEState> {
  final BleRepository _repository;

  ListenBleState(this._repository);

  @override
  ResultStream<BLEState> call() {
    return _repository.bleStateStream();
  }
}
