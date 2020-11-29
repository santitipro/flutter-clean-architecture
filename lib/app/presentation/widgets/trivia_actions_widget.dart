import 'package:flutter/material.dart';
import 'package:flutterCleanArchitecture/app/presentation/blocs/number_trivia/number_trivia_bloc.dart';
import 'package:flutterCleanArchitecture/app/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaActions extends StatefulWidget {
  @override
  _TriviaActionsState createState() => _TriviaActionsState();
}

class _TriviaActionsState extends State<TriviaActions> {
  final TextEditingController _controller = TextEditingController();
  NumberTriviaBloc _bloc;
  String searchStr;

  @override
  void initState() {
    _bloc = BlocProvider.of<NumberTriviaBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Placeholder(fallbackHeight: 30),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value) => searchStr = value,
            onSubmitted: (_) => handleConcreteTrivia,
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: RaisedButton(
                  child: BasicText('Search'),
                  onPressed: handleConcreteTrivia,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: RaisedButton(
                  child: BasicText('Random number'),
                  onPressed: handleRandomTrivia,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void handleConcreteTrivia() {
    _bloc.add(GetTriviaForConcreteNumber(searchStr));
  }

  void handleRandomTrivia() {
    _controller.clear();
    setState(() => searchStr = null);
    _bloc.add(GetTriviaForRandomNumber());
  }
}
