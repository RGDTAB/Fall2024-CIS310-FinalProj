import 'package:ble_temperature/core/typedefs/typedefs.dart';

abstract class LaunchUrlRepository {
  ResultFuture<void> launchUrl(String url);
}
