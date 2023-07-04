import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'failure.dart';

part 'use_case.freezed.dart';
part 'use_case.g.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

@freezed
class NoParams with _$NoParams {
  const factory NoParams() = _NoParams;

  factory NoParams.fromJson(Map<String, dynamic> json) =>
      _$NoParamsFromJson(json);
}
