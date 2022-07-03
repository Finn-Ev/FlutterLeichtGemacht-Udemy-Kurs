import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:advisor_app/infrastructure/models/advice_model.dart';
import "package:http/http.dart" as http;

abstract class AdviceRemoteDatasource {
  /// Gets the [AdviceEntity] from the remote source.
  /// throws [ServerFailure] if the server doesn't respond with 200.
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  final url = "https://api.adviceslip.com/advice";
  final http.Client client;

  AdviceRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get((Uri.parse(url)), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      return AdviceModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
