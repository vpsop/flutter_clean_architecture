import 'package:flutter_clean_architecture/application/pages/advice/bloc/advicer_bloc.dart';
import 'package:flutter_clean_architecture/data/datasources/advice_remote_datasource.dart';
import 'package:flutter_clean_architecture/data/repositories/advice_repo_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/advice_repo.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
  // Application Layer
  // Factory == every time a new/fresh instance of that class
  sl.registerFactory(() => AdvicerBloc(adviceUseCases: sl()));

  // Domain Layer
  sl.registerFactory(() => AdviceUsecases(adviceRepo: sl()));

  // Data Layer
  sl.registerFactory<AdviceRepo>(
    () => AdviceRepoImpl(adviceRemoteDataSource: sl()),
  );

  sl.registerFactory<AdviceRemoteDataSource>(
    () => AdviceRemoteDataSourceImpl(client: sl()),
  );


  // Externs
  sl.registerFactory(() => http.Client());
}
