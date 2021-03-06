part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaEmpty extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaLoaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  NumberTriviaLoaded({@required this.numberTrivia});

  @override
  List<Object> get props => [numberTrivia];
}

class NumberTriviaError extends NumberTriviaState {
  final String message;

  NumberTriviaError({@required this.message});

  @override
  List<Object> get props => [message];
}
