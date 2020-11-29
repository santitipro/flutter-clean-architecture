import 'dart:convert';

import 'package:flutterCleanArchitecture/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterCleanArchitecture/app/data/models/number_trivial_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTrivialModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTrivialModel numberTrivialModel);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTrivialModel numberTrivialModel) {
    final jsonString = json.encode(numberTrivialModel.toJson());
    return sharedPreferences.setString(CACHED_NUMBER_TRIVIA, jsonString);
  }

  @override
  Future<NumberTrivialModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTrivialModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
