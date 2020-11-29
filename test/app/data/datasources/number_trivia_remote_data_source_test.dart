import 'dart:convert';

import 'package:flutterCleanArchitecture/app/data/models/number_trivial_model.dart';
import 'package:flutterCleanArchitecture/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:flutterCleanArchitecture/app/data/datasources/number_trivia_remote_data_source.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getRandomNumberTrivia', () {
    final NumberTrivialModel numberTrivialModel =
        NumberTrivialModel.fromJson(json.decode(fixture('trivia.json')));
    test(
        'should preform a GET request on a URL with *random* endpoint with application/json header',
        () {
      setUpMockHttpClientSuccess200();

      remoteDataSource.getRandomNumberTrivia();

      verify(mockHttpClient.get('http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200 (success)', () async {
      setUpMockHttpClientSuccess200();

      final result = await remoteDataSource.getRandomNumberTrivia();

      expect(result, equals(numberTrivialModel));
    });

    test('should throw a ServerException when te response code is 404 or other', () {
      setUpMockHttpClientFailure404();

      final call = remoteDataSource.getRandomNumberTrivia;

      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final NumberTrivialModel tNumberTrivialModel =
        NumberTrivialModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      setUpMockHttpClientSuccess200();

      remoteDataSource.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get(
        'http://numbersapi.com/$tNumber',
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await remoteDataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTrivialModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () {
      setUpMockHttpClientFailure404();

      final call = remoteDataSource.getConcreteNumberTrivia;

      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
