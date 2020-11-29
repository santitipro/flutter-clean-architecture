import 'dart:async';
import 'package:flutterCleanArchitecture/app/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutterCleanArchitecture/app/domain/usecases/get_random_number_trivia.dart';
import 'package:flutterCleanArchitecture/core/usecases/usecase.dart';
import 'package:flutterCleanArchitecture/core/util/input_converter.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concreteNumberTrivia;
  final GetRandomNumberTrivia randomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {@required this.concreteNumberTrivia,
      @required this.randomNumberTrivia,
      @required this.inputConverter})
      : super(NumberTriviaEmpty());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      yield* _mapGetTriviaForConcreteNumberToState(event.number);
    }
    if (event is GetTriviaForRandomNumber) {
      yield* _mapGetTriviaForRandomNumberToState();
    }
  }

  Stream<NumberTriviaState> _mapGetTriviaForConcreteNumberToState(
      String number) async* {

    final inputEither = inputConverter.stringToUnsignedInteger(number);

    yield* inputEither.fold(
      (failure) async* {
        print(number);
        yield NumberTriviaError(message: INVALID_INPUT_FAILURE_MESSAGE);
      },
      (integer) async* {
        yield NumberTriviaLoading();
        final responseEither = await concreteNumberTrivia(Params(number: integer));
        yield responseEither.fold(
            (failure) => NumberTriviaError(message: SERVER_FAILURE_MESSAGE),
            (trivia) => NumberTriviaLoaded(numberTrivia: trivia));
      },
    );
  }

  Stream<NumberTriviaState> _mapGetTriviaForRandomNumberToState() async* {
    yield NumberTriviaLoading();
    final responseEither = await randomNumberTrivia(NoParams());
    yield responseEither.fold(
      (failure) => NumberTriviaError(message: SERVER_FAILURE_MESSAGE),
      (trivia) => NumberTriviaLoaded(numberTrivia: trivia)
    );
  }
}
