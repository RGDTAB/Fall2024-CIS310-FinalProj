import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_page_params.freezed.dart';

@freezed
class LivePageParams with _$LivePageParams {
  factory LivePageParams({
    required DiscoveredDevice device,
  }) = _LivePageParams;
}
