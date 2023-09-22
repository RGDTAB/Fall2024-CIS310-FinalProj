part of 'scan_cubit.dart';

class ScanState extends Equatable {
  final ScanDictionary scans;

  const ScanState({required this.scans});

  @override
  List<Object?> get props => [scans];
}
