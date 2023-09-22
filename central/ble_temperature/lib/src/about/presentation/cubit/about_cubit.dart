import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:ble_temperature/src/about/domain/usecases/launch_url.dart';
import 'package:ble_temperature/src/about/domain/usecases/load_app_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit({
    required LoadAppInfo loadAppInfo,
    required LaunchUrl launchUrl,
  })  : _loadAppInfo = loadAppInfo,
        _launchUrl = launchUrl,
        super(const AboutStateLoading());
  final LoadAppInfo _loadAppInfo;
  final LaunchUrl _launchUrl;

  Future<void> load() async {
    final result = await _loadAppInfo();
    result.fold((l) => null, (r) => emit(AboutStateUpdate(appInfoResult: r)));
  }

  Future<void> launchUrl(String url) async {
    debugPrint(url);
    final _ = await _launchUrl(url);
  }
}
