import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/app_ble.dart';

part 'scan_cubit.freezed.dart';
part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final BleStartScan ucScan;

  StreamSubscription<DiscoveredDevice>? _sub;

  ScanCubit({required this.ucScan})
      : super(const ScanState(scans: ScanDictionary()));

  Future<void> startScan() async {
    final result = await ucScan(BleStartScanParams(name: AppBle.advName));
    result.fold((l) => null, (r) {
      _sub = r.listen(_onScan);
    });
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
