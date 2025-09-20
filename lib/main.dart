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
import 'package:trash2cash/features/auth/presentation/pages/login_page.dart';
import 'package:trash2cash/features/choose_role/data/datasources/user_remote_data_source.dart';
import 'package:trash2cash/features/choose_role/data/repositories/user_repository_impl.dart';
import 'package:trash2cash/features/choose_role/domain/repositories/user_repositories.dart';
import 'package:trash2cash/features/choose_role/domain/usecases/update_use_role.dart';
import 'package:trash2cash/features/choose_role/presentation/bloc/user_role_bloc.dart';
import 'package:trash2cash/features/make_payment/data/datasources/payment_remote_data_source.dart';
import 'package:trash2cash/features/make_payment/data/repositories/payment_repository_impl.dart';
import 'package:trash2cash/features/make_payment/domain/repositories/payment_repository.dart';
import 'package:trash2cash/features/make_payment/domain/usecases/accept_wast_listing.dart';
import 'package:trash2cash/features/make_payment/presentation/bloc/payment_bloc.dart';
import 'package:trash2cash/features/notification/data/datasources/notification_remote_data_sorce.dart';
import 'package:trash2cash/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:trash2cash/features/notification/domain/repositories/notification_repository.dart';
import 'package:trash2cash/features/notification/domain/usecases/get_notifiction.dart';
import 'package:trash2cash/features/notification/domain/usecases/get_unread_notification_count.dart';
import 'package:trash2cash/features/notification/domain/usecases/mark_all_notification_as_read.dart';
import 'package:trash2cash/features/notification/domain/usecases/mark_notification_as_read.dart';
import 'package:trash2cash/features/notification/presentation/bloc/notification_badge_bloc.dart';
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
import 'package:trash2cash/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:trash2cash/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:trash2cash/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:trash2cash/features/schedule/domain/usecases/create_shedule.dart';
import 'package:trash2cash/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:trash2cash/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:trash2cash/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:trash2cash/features/wallet/domain/repositories/wallet_repositories.dart';
import 'package:trash2cash/features/wallet/domain/usecases/usecases.dart';
import 'package:trash2cash/features/wallet/domain/usecases/withdraw_funds.dart';
import 'package:trash2cash/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:trash2cash/features/wallet/presentation/bloc/withdrawal/withdrawal_bloc.dart';
import 'package:trash2cash/features/waste/data/datasources/waste_listing_remote_data_source.dart';
import 'package:trash2cash/features/waste/data/repositories/waste_repository_impl.dart';
import 'package:trash2cash/features/waste/domain/repositories/waste_repository.dart';
import 'package:trash2cash/features/waste/domain/usecases/create_waste_listing.dart';
import 'package:trash2cash/features/waste/domain/usecases/get_all_wase_listing.dart';
import 'package:trash2cash/features/waste/domain/usecases/get_waste_listing.dart';
import 'package:trash2cash/features/waste/presentation/bloc/create_listing_bloc.dart';
import 'package:trash2cash/features/waste/presentation/bloc/listings_bloc.dart';
import 'package:trash2cash/features/waste/presentation/bloc/recycler_listings_bloc.dart';

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
final httpClient = http.Client();
  final box = GetStorage();
  late Widget defaultHome;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  

  bool isLoggedIn = box.read('isLoggedIn') ?? false;
  defaultHome = isLoggedIn ? const LoginPage() : const Onboarding();

  // Data Sources
  final authRemoteDataSource = AuthRemoteDataSourceImpl(client: httpClient);
  final authLocalDataSource = AuthLocalDataSourceImpl();
  final wasteRemoteDataSource =
      WasteRemoteDataSourceImpl(client: httpClient, box: box);
  final profileRemoteDataSource =
      ProfileRemoteDataSourceImpl(client: httpClient, box: box);
  final activityRemoteDataSource =
      ActivityRemoteDataSourceImpl(client: httpClient, box: box);
  final notificationRemoteDataSource =
      NotificationRemoteDataSourceImpl(client: httpClient, box: box);
      final scheduleRemoteDataSource = ScheduleRemoteDataSourceImpl(client: httpClient, box: box);
      final paymentRemoteDataSource = PaymentRemoteDataSourceImpl(client: httpClient, box: box);
      final walletRemoteDataSource = WalletRemoteDataSourceImpl(client: httpClient, box: box);

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
  final activityRepository =
      ActivityRepositoryImpl(remoteDataSource: activityRemoteDataSource);
  final notificationRepository = NotificationRepositoryImpl(
      remoteDataSource: notificationRemoteDataSource);
  final scheduleRepository = ScheduleRepositoryImpl(remoteDataSource: scheduleRemoteDataSource);
    final paymentRepository = PaymentRepositoryImpl(remoteDataSource: paymentRemoteDataSource);
    final walletRepository = WalletRepositoryImpl(remoteDataSource: walletRemoteDataSource);


  runApp(MyApp(
      authRepository: authRepository,
      userRepository: userRepository,
      profileRepository: profileRepository,
      wasteRepository: wasteRepository,
      activityRepository: activityRepository,
      notificationRepository: notificationRepository,
      scheduleRepository: scheduleRepository,
      paymentRepository: paymentRepository,
      walletRepository: walletRepository,
      
      ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ProfileRepository profileRepository;
  final WasteRepository wasteRepository;
  final ActivityRepository activityRepository;
  final NotificationRepository notificationRepository;
  final ScheduleRepository scheduleRepository;
  final PaymentRepository paymentRepository;
  final WalletRepository walletRepository; 
  const MyApp(
      {super.key,
      required this.authRepository,
      required this.userRepository,
      required this.profileRepository,
      required this.wasteRepository,
      required this.activityRepository,
      required this.notificationRepository,
      
      required this.scheduleRepository, required this.paymentRepository, required this.walletRepository,
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
              markNotificationAsRead:
                  MarkNotificationAsRead(notificationRepository),
              markAllNotificationsAsRead:
                  MarkAllNotificationsAsRead(notificationRepository),
            ),
          ),
          BlocProvider<NotificationBadgeBloc>(
              create: (_) => NotificationBadgeBloc(
                    getUnreadCount:
                        GetUnreadNotificationCount(notificationRepository),
                  )),
          BlocProvider<RecyclerListingsBloc>(
            create: (_) => RecyclerListingsBloc(
              getAllListings: GetAllWasteListings(wasteRepository),
            ),
          ),
          BlocProvider<ScheduleBloc>(
            create: (_) => ScheduleBloc(
              createSchedule: CreateSchedule(scheduleRepository),
            ),
          ),
           BlocProvider<PaymentBloc>(
          create: (_) => PaymentBloc(
            acceptWasteListing: AcceptWasteListing(paymentRepository),
          ),
        ),
        BlocProvider<WalletBloc>(
            create: (_) => WalletBloc(
              getWalletDetails: GetWalletDetails(walletRepository),
            ),
          ),

        BlocProvider<WithdrawalBloc>(
    create: (_) => WithdrawalBloc(
      withdrawFunds: WithdrawFunds(walletRepository), // walletRepository is already created
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
          home: defaultHome,
        ),
      ),
    );
  }
}
