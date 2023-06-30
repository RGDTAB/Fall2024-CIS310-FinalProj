part of 'scan_cubit.dart';

@freezed
class ScanState with _$ScanState {
  const factory ScanState.update({required ScanDictionary scans}) = _Update;
}
