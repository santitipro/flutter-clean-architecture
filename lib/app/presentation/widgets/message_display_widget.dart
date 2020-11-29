import 'package:flutter/material.dart';
import 'package:flutterCleanArchitecture/app/presentation/widgets/widgets.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: BasicText(
          message,
          size: 25,
          align: TextAlign.center,
        ),
      ),
    );
  }
}