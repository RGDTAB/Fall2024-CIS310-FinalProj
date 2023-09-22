part of 'scan_cubit.dart';

class ScanState extends Equatable {
  const ScanState({required this.scans});
  final ScanDictionary scans;

  @override
  List<Object?> get props => [scans];
}
