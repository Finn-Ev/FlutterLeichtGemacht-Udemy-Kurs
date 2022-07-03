import 'package:advisor_app/fixtures/fixture_reader.dart';
import 'package:advisor_app/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:advisor_app/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource.test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const url = "https://api.adviceslip.com/advice";
  final jsonAdvice = FixtureReader.get('advice.json');

  late MockClient mockClient;
  late AdviceRemoteDatasourceImpl adviceRemoteDatasource;
  setUp(() {
    mockClient = MockClient();
    adviceRemoteDatasource = AdviceRemoteDatasourceImpl(client: mockClient);
  });

  void setupMockClientSuccess() {
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response(jsonAdvice, 200),
    );
  }

  void setupMockClientFailure() {
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response("Something went wrong", 500),
    );
  }

  group('getRandomAdviceFromApi', () {
    final tAdviceModel = AdviceModel.fromJson(jsonAdvice);

    test('should perform a Get-Request to https://api.adviceslip.com/advice with the header application/json', () async {
      // arrange
      setupMockClientSuccess();

      // act
      adviceRemoteDatasource.getRandomAdviceFromApi();

      // assert
      verify(mockClient.get((Uri.parse(url)), headers: {
        "Content-Type": "application/json",
      }));
    });

    test("should return a valid advice when the response-code is 200", () async {
      // arrange
      setupMockClientSuccess();

      // act
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();

      //assert
      expect(result, tAdviceModel);
    });

    test("should throw a ServerException when the response-code is not 200", () async {
      // arrange
      setupMockClientFailure();

      // act
      final call = adviceRemoteDatasource.getRandomAdviceFromApi;

      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
