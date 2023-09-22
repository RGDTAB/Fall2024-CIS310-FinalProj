import 'package:equatable/equatable.dart';

class AppInfoResult extends Equatable {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  const AppInfoResult(
      {required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber});

  @override
  List<Object?> get props => [appName, packageName, version, buildNumber];
}
