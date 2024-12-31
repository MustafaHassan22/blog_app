import 'package:blogapp/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccsesType, Params> {
  Future<Either<Failure, SuccsesType>> call(Params param);
}
