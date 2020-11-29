import 'package:flutterCleanArchitecture/app/data/models/number_trivial_model.dart';
import 'package:flutterCleanArchitecture/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import 'package:flutterCleanArchitecture/app/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutterCleanArchitecture/app/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';
import 'package:flutterCleanArchitecture/app/domain/repositories/number_trivia_repository.dart';
import 'package:flutterCleanArchitecture/core/error/failures.dart';
import 'package:flutterCleanArchitecture/core/network/network_info.dart';

class NumberTriviaRespositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRespositoryImpl({
      @required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    return await _getNumberTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getNumberTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(Function getConcreteOrRandomNumberTrivia) async {
    if (await networkInfo.isConnected) {
      try {
        final NumberTrivialModel numberTrivial = await getConcreteOrRandomNumberTrivia();
        await localDataSource.cacheNumberTrivia(numberTrivial);
        return Right(numberTrivial);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final NumberTrivialModel numberTrivial = await localDataSource.getLastNumberTrivia();
        return Right(numberTrivial);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
