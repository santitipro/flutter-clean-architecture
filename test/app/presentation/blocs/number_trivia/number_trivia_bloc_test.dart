import 'package:dartz/dartz.dart';
import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';
import 'package:flutterCleanArchitecture/app/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutterCleanArchitecture/app/domain/usecases/get_random_number_trivia.dart';
import 'package:flutterCleanArchitecture/app/presentation/blocs/number_trivia/number_trivia_bloc.dart';
import 'package:flutterCleanArchitecture/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        concreteNumberTrivia: mockGetConcreteNumberTrivia,
        randomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    expect(bloc.state, equals(NumberTriviaEmpty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '123';
    final tNumberParsed = 123;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final expected = [
        NumberTriviaEmpty(),
        NumberTriviaError(message: INVALID_INPUT_FAILURE_MESSAGE)
      ];

      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    // test(
    //   'should get data from the concrete use case',
    //   () async {
    //     // arrange
    //     when(mockInputConverter.stringToUnsignedInteger(any))
    //         .thenReturn(Right(tNumberParsed));
    //     when(mockGetConcreteNumberTrivia(any))
    //         .thenAnswer((_) async => Right(tNumberTrivia));
    //     // act
    //     bloc.add(GetTriviaForConcreteNumber(tNumberString));
    //     await untilCalled(mockGetConcreteNumberTrivia(any));
    //     // assert
    //     verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    //   },
    // );
  });
}
