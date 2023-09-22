import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/scan_dictionary.dart';

extension MutableScanDictionary on ScanDictionary {
  ScanDictionary addItem(DiscoveredDevice d) {
    final copy = Map<String, DiscoveredDevice>.from(items);
    copy[d.id] = d;
    return ScanDictionary(copy);
  }

  ScanDictionary clear() {
    return const ScanDictionary();
  }
}
