
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterCleanArchitecture/app/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutterCleanArchitecture/app/data/models/number_trivial_model.dart';
import 'package:flutterCleanArchitecture/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}
void main() {

    NumberTriviaLocalDataSourceImpl localDataSource;
    MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      localDataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
    });

    group('getLastNumberTrivia', () {
      final tNumberTriviaModel = NumberTrivialModel.fromJson(json.decode(fixture('trivia_cached.json')));

      test('should return NumberTrivia from SharedPreferences when there is one in the cache', () async {
        when(mockSharedPreferences.getString(any)).thenAnswer((_) => fixture('trivia_cached.json'));

        final result = await localDataSource.getLastNumberTrivia();

        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      });

      test('should throw a CacheException when there is not a cached value', () async {
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        final call = localDataSource.getLastNumberTrivia;

        expect(() => call(), throwsA(isInstanceOf<CacheException>()));
      });
    });

    group('cacheNumberTrivia', () {
      final NumberTrivialModel numberTrivialModel = NumberTrivialModel(text: 'text', number: 1);

      test('should call SharedPreferences to cache the data', () {
        localDataSource.cacheNumberTrivia(numberTrivialModel);

        final trivialModelString = json.encode(numberTrivialModel.toJson());
        verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, trivialModelString));
      });

    });

}