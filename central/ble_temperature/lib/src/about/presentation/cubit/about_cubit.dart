import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:ble_temperature/src/about/domain/usecases/load_app_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit({required LoadAppInfo loadAppInfo})
      : _loadAppInfo = loadAppInfo,
        super(const AboutStateLoading());
  final LoadAppInfo _loadAppInfo;

  Future<void> load() async {
    final result = await _loadAppInfo();
    result.fold((l) => null, (r) => emit(AboutStateUpdate(appInfoResult: r)));
  }
}
