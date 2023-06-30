import '../../domain.dart';

extension MutableScanDictionary on ScanDictionary {
  ScanDictionary addItem(DiscoveredDevice d) {
    final copy = Map<String, DiscoveredDevice>.from(items);
    copy[d.id] = d;
    return ScanDictionary(copy);
  }

  ScanDictionary clear() {
    return ScanDictionary();
  }
}
