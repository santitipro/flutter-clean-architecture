import 'package:dartz/dartz.dart';

import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';
import 'package:flutterCleanArchitecture/core/error/failures.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
