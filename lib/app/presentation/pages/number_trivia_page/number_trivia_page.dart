import 'package:flutter/material.dart';
import 'package:flutterCleanArchitecture/app/presentation/blocs/number_trivia/number_trivia_bloc.dart';
import 'package:flutterCleanArchitecture/app/presentation/widgets/widgets.dart';
import 'package:flutterCleanArchitecture/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Number Trivia')), body: body(context));
  }

  Widget body(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
              if (state is NumberTriviaLoading) {
                return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: LoadingIndicator());
              }
              if (state is NumberTriviaEmpty) {
                return MessageDisplay(message: 'Start searching!');
              }
              if (state is NumberTriviaError) {
                return MessageDisplay(message: state.message);
              }
              if (state is NumberTriviaLoaded) {
                return TriviaNumberDisplay(numberTrivia: state.numberTrivia);
              }
              return Container();
            }),
            SizedBox(height: 40.0),
            TriviaActions()
          ],
        ),
      ),
    );
  }
}
