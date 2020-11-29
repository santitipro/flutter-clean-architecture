
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterCleanArchitecture/app/data/models/number_trivial_model.dart';
import 'package:flutterCleanArchitecture/app/domain/entities/number_trivia.dart';

void main() {
  final tNumberTrivialModel = NumberTrivialModel(text: 'test', number: 1);

  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTrivialModel, isA<NumberTrivia>());
  });
}