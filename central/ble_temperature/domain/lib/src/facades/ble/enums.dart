enum DeviceConnectionState {
  connected,
  connecting,
  disconnected,
  disconnecting,
}

enum BLEState {
  /// Status is not (yet) determined.
  unknown,

  /// BLE is not supported on this device.
  unsupported,

  /// BLE usage is not authorized for this app.
  unauthorized,

  /// BLE is turned off.
  poweredOff,

  /// Android only: Location services are disabled.
  locationServicesDisabled,

  /// BLE is fully operating for this app.
  ready
}

///Android only:  mode in which BLE discovery is executed.
enum ScanMode {
  /// passively listen for other scan results without starting BLE scan itself.
  opportunistic,

  /// scanmode which has the lowest battery consumption.
  lowPower,

  /// scanmode that is a good compromise between battery consumption and latency.
  balanced,

  ///Scanmode with highest battery consumption and lowest latency.
  ///Should not be used when scanning for a long time.
  lowLatency,
}
