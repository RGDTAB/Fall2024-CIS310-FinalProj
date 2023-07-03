import '../../domain.dart';

class ScanDictionary {
  final Map<String, DiscoveredDevice> _items;

  Map<String, DiscoveredDevice> get items => Map.unmodifiable(_items);

  const ScanDictionary([this._items = const {}]);
}
