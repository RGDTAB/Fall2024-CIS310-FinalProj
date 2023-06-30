import 'package:freezed_annotation/freezed_annotation.dart';

part 'ios_info.freezed.dart';

@freezed
class IOSInfo with _$IOSInfo {
  factory IOSInfo({required String systemVersion}) = _IOSInfo;
}
