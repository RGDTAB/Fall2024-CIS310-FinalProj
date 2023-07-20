import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'scan_dictionary.freezed.dart';

@freezed
class ScanDictionary with _$ScanDictionary {
  const factory ScanDictionary(
      [@Default({}) Map<String, DiscoveredDevice> items]) = _ScanDictionary;
}
