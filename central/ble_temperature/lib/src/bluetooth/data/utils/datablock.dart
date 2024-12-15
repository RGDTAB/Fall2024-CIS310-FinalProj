import 'package:equatable/equatable.dart';

class Datablock extends Equatable{
  const Datablock({required this.temp, required this.hum, required this.light,
    required this.noise, required this.flag});
  final double temp;
  final double hum;
  final int light;
  final int noise;
  final bool flag;

  @override
  List<Object?> get props => [temp, hum, light, noise, flag];

}
