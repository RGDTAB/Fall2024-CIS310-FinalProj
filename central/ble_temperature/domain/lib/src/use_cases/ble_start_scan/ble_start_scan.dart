import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain.dart';
import '../../core/use_case/failure.dart';

part 'ble_start_scan.freezed.dart';

class BleStartScan
    implements UseCase<Stream<DiscoveredDevice>, BleStartScanParams> {
  final BleFacade _bleFacade;

  BleStartScan(this._bleFacade);

  @override
  Future<Either<Failure, Stream<DiscoveredDevice>>> call(
      BleStartScanParams params) {
    final result = _bleFacade.scanForDevices(
        withServices: []).where((event) => event.name == params.name);
    return Future.value(right(result));
  }
}

@freezed
class BleStartScanParams with _$BleStartScanParams {
  factory BleStartScanParams({
    required String name,
  }) = _BleStartScanParams;
}
