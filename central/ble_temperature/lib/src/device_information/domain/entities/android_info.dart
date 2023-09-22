import 'package:equatable/equatable.dart';

class AndroidInfo extends Equatable {
  const AndroidInfo({required this.sdkInt});

  final int sdkInt;

  @override
  List<Object?> get props => [sdkInt];
}
