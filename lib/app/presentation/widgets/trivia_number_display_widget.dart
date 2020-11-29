import 'package:flutter/material.dart';
import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';
import 'package:flutterCleanArchitecture/app/presentation/widgets/widgets.dart';

class TriviaNumberDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaNumberDisplay({@required this.numberTrivia})
      : assert(numberTrivia != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          SizedBox(height: 20.0),
          BasicText(
            numberTrivia.number.toString(),
            size: 39.0,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: BasicText(
                numberTrivia.text,
                size: 18,
                color: Colors.black,
                align: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
