import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

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
    injector.registerFactory<ChatDatasource>(
      () => ChatRemoteDatasource(client: injector()),
    );
    injector.registerFactory<LocalDatasource>(() => LocalRemoteDatasource());

    // REPOSITORIES
    injector.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: injector()),
    );
    injector.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(remoteDatasource: injector()),
    );
    injector.registerFactory<LocalRepository>(
      () => LocalRepositoryImpl(remoteDatasource: injector()),
    );

    // BLOCS AND CUBITS
    injector.registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: injector()),
    );
    injector.registerFactory<DashboardCubit>(
      () => DashboardCubit(
        localRepository: injector(),
        authRepository: injector(),
      ),
    );
    injector.registerFactory<ChatCubit>(
      () => ChatCubit(chatRepository: injector(), localRepository: injector()),
    );

    // INTERCEPTORS
  }
}
