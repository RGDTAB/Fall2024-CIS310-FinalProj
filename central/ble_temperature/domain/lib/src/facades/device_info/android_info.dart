import 'package:freezed_annotation/freezed_annotation.dart';

part 'android_info.freezed.dart';

@freezed
class AndroidInfo with _$AndroidInfo {
  factory AndroidInfo({
    required int sdkInt,
  }) = _AndroidInfo;
}
