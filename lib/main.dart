import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:trash2cash/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/features/activity/data/datasources/activity_remote_data_source.dart';
import 'package:trash2cash/features/activity/data/repository/activity_repository_impl.dart';
import 'package:trash2cash/features/activity/domain/repositories/activity_repository.dart';
import 'package:trash2cash/features/activity/domain/usecases/get_activities.dart';
import 'package:trash2cash/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:trash2cash/features/choose_role/data/datasources/user_remote_data_source.dart';
import 'package:trash2cash/features/choose_role/data/repositories/user_repository_impl.dart';
import 'package:trash2cash/features/choose_role/domain/repositories/user_repositories.dart';
import 'package:trash2cash/features/choose_role/domain/usecases/update_use_role.dart';
import 'package:trash2cash/features/choose_role/presentation/bloc/user_role_bloc.dart';
import 'package:trash2cash/features/notification/data/datasources/notification_remote_data_sorce.dart';
import 'package:trash2cash/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:trash2cash/features/notification/domain/repositories/notification_repository.dart';
import 'package:trash2cash/features/notification/domain/usecases/get_notifiction.dart';
import 'package:trash2cash/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:trash2cash/features/onboarding/presentation/pages/onboarding.dart';
import 'package:trash2cash/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:trash2cash/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:trash2cash/features/profile/domain/entities/user_profile.dart';
import 'package:trash2cash/features/profile/domain/repositories/profile_repository.dart';
import 'package:trash2cash/features/profile/domain/usecases/get_user_profile.dart';
import 'package:trash2cash/features/profile/domain/usecases/update_user_profile.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trash2cash/features/profile/presentation/pages/profile_setup_page.dart';
import 'package:http/http.dart' as http;
import 'package:trash2cash/features/waste/data/datasources/waste_listing_remote_data_source.dart';
import 'package:trash2cash/features/waste/data/repositories/waste_repository_impl.dart';
import 'package:trash2cash/features/waste/domain/repositories/waste_repository.dart';
import 'package:trash2cash/features/waste/domain/usecases/create_waste_listing.dart';
import 'package:trash2cash/features/waste/domain/usecases/get_waste_listing.dart';
import 'package:trash2cash/features/waste/presentation/bloc/create_listing_bloc.dart';
import 'package:trash2cash/features/waste/presentation/bloc/listings_bloc.dart';

// Data Sources
import 'features/Auth/data/datasources/auth_local_data_source.dart';
import 'features/Auth/data/datasources/auth_remote_data_source.dart';

// Repositories
import 'features/Auth/data/repositories/auth_repository_impl.dart';
import 'features/Auth/domain/repositories/auth_repository.dart';

// Use Cases
import 'features/Auth/domain/usecases/login_user.dart';
import 'features/Auth/domain/usecases/register_user.dart';

// BLoCs
import 'features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:trash2cash/features/profile/presentation/bloc/location/location_bloc.dart';

// Your initial page
// Or your AuthSelection page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final httpClient = http.Client();
  final box = GetStorage();

  // Data Sources
  final authRemoteDataSource = AuthRemoteDataSourceImpl(client: httpClient);
  final authLocalDataSource = AuthLocalDataSourceImpl();
  final wasteRemoteDataSource =
      WasteRemoteDataSourceImpl(client: httpClient, box: box);
  final profileRemoteDataSource =
      ProfileRemoteDataSourceImpl(client: httpClient, box: box);
      final activityRemoteDataSource = ActivityRemoteDataSourceImpl(client: httpClient, box: box);
      final notificationRemoteDataSource = NotificationRemoteDataSourceImpl(client: httpClient, box: box);

  // Repositories (the top-level dependency we need to pass down)
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    localDataSource: authLocalDataSource,
  );

  final userRemoteDataSource = UserRemoteDataSourceImpl(client: httpClient);
  final userRepository =
      UserRepositoryImpl(remoteDataSource: userRemoteDataSource);

  final profileRepository =
      ProfileRepositoryImpl(remoteDataSource: profileRemoteDataSource);
  final wasteRepository =
      WasteRepositoryImpl(remoteDataSource: wasteRemoteDataSource);
       final activityRepository = ActivityRepositoryImpl(remoteDataSource: activityRemoteDataSource);
       final notificationRepository = NotificationRepositoryImpl(remoteDataSource: notificationRemoteDataSource);

      
  runApp(MyApp(
    authRepository: authRepository,
    userRepository: userRepository,
    profileRepository: profileRepository,
    wasteRepository: wasteRepository,
    activityRepository: activityRepository,
    notificationRepository: notificationRepository
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ProfileRepository profileRepository;
  final WasteRepository wasteRepository;
  final ActivityRepository activityRepository;
  final NotificationRepository notificationRepository;
  const MyApp(
      {super.key,
      required this.authRepository,
      required this.userRepository,
      required this.profileRepository,
      required this.wasteRepository,
      required this.activityRepository,
      required this.notificationRepository
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                    registerUser: RegisterUser(authRepository),
                    loginUser: LoginUser(authRepository),
                  )),
          BlocProvider<LocationBloc>(
            create: (_) => LocationBloc(),
          ),
          BlocProvider<UserRoleBloc>(
            create: (_) => UserRoleBloc(
              updateUserRole: UpdateUserRole(userRepository),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              getUserProfile: GetUserProfile(profileRepository),
              updateUserProfile: UpdateUserProfile(profileRepository),
            ),
          ),
          BlocProvider<CreateListingBloc>(
            create: (_) => CreateListingBloc(
              createWasteListing: CreateWasteListing(wasteRepository),
            ),
          ),
          BlocProvider<ListingsBloc>(
            create: (_) => ListingsBloc(
              getWasteListings: GetWasteListings(wasteRepository),
            ),
          ),
           BlocProvider<ActivityBloc>(
            create: (_) => ActivityBloc(
              getActivities: GetActivities(activityRepository),
            ),
          ),

          BlocProvider<NotificationBloc>(
            create: (_) => NotificationBloc(
              getNotifications: GetNotifications(notificationRepository),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'trash2cash',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Onboarding(),
        ),
      ),
    );
  }
}
