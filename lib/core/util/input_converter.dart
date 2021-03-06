import 'package:dartz/dartz.dart';
import 'package:flutterCleanArchitecture/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      return Right(int.parse(str));
    } catch(e) {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
