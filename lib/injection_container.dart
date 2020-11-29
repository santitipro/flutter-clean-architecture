import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:flutterCleanArchitecture/app/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutterCleanArchitecture/app/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutterCleanArchitecture/app/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutterCleanArchitecture/app/domain/repositories/number_trivia_repository.dart';
import 'package:flutterCleanArchitecture/app/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutterCleanArchitecture/app/domain/usecases/get_random_number_trivia.dart';
import 'package:flutterCleanArchitecture/app/presentation/blocs/number_trivia/number_trivia_bloc.dart';
import 'package:flutterCleanArchitecture/core/network/network_info.dart';
import 'package:flutterCleanArchitecture/core/util/input_converter.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => NumberTriviaBloc(
      concreteNumberTrivia: sl(),
      randomNumberTrivia: sl(),
      inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repositories
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRespositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
