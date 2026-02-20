import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:test_multiplier_app/src/features/auth/auth.dart';

GetIt get injector => GetIt.instance;

abstract class DependencyInjection {
  static initialize() {
    // DIO
    injector.registerFactory<Dio>(() => Dio());

    // FIREBASE AUTH
    injector.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    // DATASOURCES
    injector.registerFactory<AuthDatasource>(
      () => AuthRemoteDatasource(client: injector()),
    );

    // REPOSITORIES
    injector.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: injector()),
    );

    // BLOCS AND CUBITS
    injector.registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: injector()),
    );

    // INTERCEPTORS
  }
}
