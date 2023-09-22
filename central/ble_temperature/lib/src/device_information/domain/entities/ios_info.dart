import 'package:equatable/equatable.dart';

class IOSInfo extends Equatable {
  const IOSInfo({required this.systemVersion});

  final String systemVersion;

  @override
  List<Object?> get props => [systemVersion];
}
