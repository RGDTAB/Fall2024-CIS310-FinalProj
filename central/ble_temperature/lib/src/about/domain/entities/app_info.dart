import 'package:equatable/equatable.dart';

class AppInfo extends Equatable {
  const AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  @override
  List<Object?> get props => [appName, packageName, version, buildNumber];
}
