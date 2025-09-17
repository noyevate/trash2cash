// import 'package:get_it/get_it.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:trash2cash/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:trash2cash/features/profile/presentation/bloc/location/location_bloc.dart';

// // Import all your layers
// // Domain
// import 'features/auth/domain/repositories/auth_repository.dart';
// import 'features/auth/domain/usecases/login_user.dart';
// import 'features/auth/domain/usecases/register_user.dart';

// // Data
// import 'features/auth/data/datasources/auth_local_data_source.dart';
// import 'features/auth/data/datasources/auth_remote_data_source.dart';
// import 'features/auth/data/repositories/auth_repository_impl.dart';

// // Presentation (BLoCs)
// import 'features/auth/presentation/bloc/auth_bloc.dart';

// // Service Locator instance
// final sl = GetIt.instance;

// Future<void> init() async {
//   // BLoCs
//   sl.registerFactory(() => AuthBloc(registerUser: sl(), loginUser: sl()));
//   sl.registerFactory(() => LocationBloc());

//   // Use Cases
//   sl.registerLazySingleton(() => RegisterUser(sl()));
//   sl.registerLazySingleton(() => LoginUser(sl()));

//   // Repositories
//   sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
//         remoteDataSource: sl(),
//         localDataSource: sl(),
//       ));

//   // Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(box: sl()));

//   // External Dependencies
//   sl.registerLazySingleton(() => GetStorage());
//   sl.registerLazySingleton(() => http.Client());
// }