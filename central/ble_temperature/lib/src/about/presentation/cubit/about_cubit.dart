import 'package:ble_temperature/src/about/domain/entities/app_info_result.dart';
import 'package:ble_temperature/src/about/domain/usecases/load_app_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  final LoadAppInfo _loadAppInfo;

  AboutCubit({required LoadAppInfo loadAppInfo})
      : _loadAppInfo = loadAppInfo,
        super(const AboutStateLoading());

  Future<void> load() async {
    final result = await _loadAppInfo();
    result.fold((l) => null, (r) => emit(AboutStateUpdate(appInfoResult: r)));
  }
}
