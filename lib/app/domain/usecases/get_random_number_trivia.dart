
import 'package:dartz/dartz.dart';

import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';
import 'package:flutterCleanArchitecture/app/domain/repositories/number_trivia_repository.dart';
import 'package:flutterCleanArchitecture/core/error/failures.dart';
import 'package:flutterCleanArchitecture/core/usecases/usecase.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
   return await repository.getRandomNumberTrivia();
  }

}