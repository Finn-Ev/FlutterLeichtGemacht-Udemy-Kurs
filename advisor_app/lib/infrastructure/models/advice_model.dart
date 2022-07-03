import 'dart:convert';

import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({
    required int id,
    required String text,
  }) : super(id: id, text: text);

  /// This Model-Function creates an [AdviceEntity] from a JSON object.
  factory AdviceModel.fromJson(String jsonAdvice) {
    final adviceContent = jsonDecode(jsonAdvice)["slip"];

    return AdviceModel(
      id: adviceContent["id"],
      text: adviceContent["advice"],
    );
  }

  @override
  List<Object?> get props => [id, text];
}
