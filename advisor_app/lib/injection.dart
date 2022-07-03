import 'package:advisor_app/application/advisor/advice_bloc.dart';
import 'package:advisor_app/domain/repositories/advice_repository.dart';
import 'package:advisor_app/domain/repositories/theme_repository.dart';
import 'package:advisor_app/domain/usecases/advice_usecases.dart';
import 'package:advisor_app/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:advisor_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advisor_app/infrastructure/repositories/advice_repository_impl.dart';
import 'package:advisor_app/infrastructure/repositories/theme_repository_impl.dart';
import "package:get_it/get_it.dart";
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
  // blocs
  sl.registerFactory<AdviceBloc>(() => AdviceBloc(useCases: sl()));

  // usecases
  sl.registerLazySingleton(() => AdviceUseCases(adviceRepository: sl()));

  // repositories
  sl.registerLazySingleton<AdviceRepository>(() => AdviceRepositoryImpl(adviceRemoteDatasource: sl()));
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeLocalDataSource: sl()));

  // datasources
  sl.registerLazySingleton<AdviceRemoteDatasource>(() => AdviceRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSourceImpl(sharedPreferences: sl()));

  // external
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() async => (await SharedPreferences.getInstance()));
}
