import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_info_result.freezed.dart';

@freezed
class AppInfoResult with _$AppInfoResult {
  factory AppInfoResult(
      {required String appName,
      required String packageName,
      required String version,
      required String buildNumber}) = _AppInfoResult;
}
