part of 'about_cubit.dart';

sealed class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

final class AboutStateLoading extends AboutState {
  const AboutStateLoading();
}

final class AboutStateUpdate extends AboutState {
  final AppInfoResult appInfoResult;

  const AboutStateUpdate({required this.appInfoResult});
}
