class AppBle {
  const AppBle._();

  /// Peripheral advertising name.
  static const String advName = 'BLE-TEMP';

  /// The Sevice UUID.
  static const String srvUuid = '00000000-5EC4-4083-81CD-A10B8D5CF6EC';

  /// The Charakteristic UUID read/notify.
  static const String chrUuid = '00000001-5EC4-4083-81CD-A10B8D5CF6EC';
}
