import 'dart:convert';

import 'package:flutterCleanArchitecture/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:flutterCleanArchitecture/app/data/models/number_trivial_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivialModel> getConcreteNumberTrivia(int number);

  Future<NumberTrivialModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTrivialModel> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTrivialModel> getRandomNumberTrivia() =>
      _getNumberTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTrivialModel> _getNumberTriviaFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTrivialModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
