import 'package:meta/meta.dart';

import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';

class NumberTrivialModel extends NumberTrivia {
  NumberTrivialModel({@required text, @required number})
      : super(text: text, number: number);

  factory NumberTrivialModel.fromJson(Map<String, dynamic> json) {
    return NumberTrivialModel(
        text: json['text'], number: (json['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
