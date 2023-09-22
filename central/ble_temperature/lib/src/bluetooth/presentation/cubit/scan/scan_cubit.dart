import 'dart:async';

import 'package:ble_temperature/core/constants/app_ble.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/start_scan.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/mutable_scan_dictionary.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/scan_dictionary.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit({required StartScan startScan})
      : _startScan = startScan,
        super(const ScanState(scans: ScanDictionary()));
  final StartScan _startScan;

  StreamSubscription<DiscoveredDevice>? _sub;

  Future<void> startScan() async {
    _startScan(AppBle.advName).listen(_onScan);
  }

  void _onScan(DiscoveredDevice d) {
    emit(ScanState(scans: state.scans.addItem(d)));
  }

  Future<void> stopScan() async {
    await _sub?.cancel();
  }

  void refresh() {
    emit(const ScanState(scans: ScanDictionary()));
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    await super.close();
  }
}
