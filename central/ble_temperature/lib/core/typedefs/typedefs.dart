import 'package:ble_temperature/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<T>;
typedef DataMap = Map<String, dynamic>;
