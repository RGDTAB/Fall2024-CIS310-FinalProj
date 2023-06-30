import '../../domain.dart';

class ScanDictionary {
  final Map<String, DiscoveredDevice> items;
  const ScanDictionary([this.items = const {}]);
}
