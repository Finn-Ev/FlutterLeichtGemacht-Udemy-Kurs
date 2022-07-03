import 'dart:convert';

import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/fixtures/fixture_reader.dart';
import 'package:advisor_app/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final adviceJson = FixtureReader.get('advice.json');
  final adviceMap = json.decode(adviceJson)['slip'];

  final tAdviceModel = AdviceModel(id: adviceMap["id"], text: adviceMap["text"]);

  test("model should be a subclass of AdviceEntity", () {
    expect(tAdviceModel, isA<AdviceEntity>());
  });

  group("fromJson Factory", () {
    test("should return a model from json", () {
      // act
      final result = AdviceModel.fromJson(adviceJson);

      // assert
      expect(result, tAdviceModel);
    });
  });
}
