import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/auth/data_layer/data_source.dart';
import '../../features/auth/data_layer/repository.dart';
import '../../features/auth/domain_layer/repository.dart';
import '../../features/auth/domain_layer/use_cases.dart';
import '../../features/auth/presentaion_layer/controller.dart';
import '../../features/group/data_layer/data_source.dart';
import '../../features/group/data_layer/repository.dart';
import '../../features/group/domain_layer/repository.dart';
import '../../features/group/domain_layer/use_cases.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../features/message/data_layer/data_source.dart';
import '../../features/message/data_layer/repository.dart';
import '../../features/message/domain_layer/repository.dart';
import '../../features/message/domain_layer/use_cases.dart';
import '../../features/message/presentaion_layer/controller.dart';
import '../../features/user/data_layer/data_source.dart';
import '../../features/user/data_layer/repository.dart';
import '../../features/user/domain_layer/repository.dart';
import '../../features/user/domain_layer/use_cases.dart';
import '../../features/user/presentaion_layer/controller.dart';
import '../network_info/network_info.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //////////////////////////////////////////////////////////////////////////
  // controllers ///////////////////////////////////////////////////////////

  // GroupController
  sl.registerFactory(() => GroupController(
      createGroupUseCase: sl(),
      updateGroupUseCase: sl(),
      addUsersGroupUseCase: sl(),
      getAllGroupsUseCase: sl()));

  // UserController
  sl.registerFactory(() => UserController(
      addUserToContactInfoUseCase: sl(),
      getUsersFromCantactsInfoUseCase: sl(),
      addGroupToUser: sl(),
      deleteGroupFromUser: sl()));

  //MessageController
  sl.registerFactory(() =>
      MessageController(sendMessageUseCase: sl(), getMessagesUseCase: sl()));

  //AuthController
  sl.registerFactory(() => AuthController(
        getUserInfo: sl(),
        signUpUseCase: sl(),
        signInUseCase: sl(),
        signOutUseCase: sl(),
      ));

  //////////////////////////////////////////////////////////////////////////
  // usecases ///////////////////////////////////////////////////////////

  //group usecases
  sl.registerLazySingleton(() => CreateGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(() => UpdateGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(
      () => AddUsersGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllGroupsUseCase(baseGroupRepository: sl()));

  //auth usecases
  sl.registerLazySingleton(() => SignUpUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(baseAuthRepository: sl()));
  sl.registerLazySingleton(() => GetUserInfo(baseAuthRepository: sl()));

  //user usecase
  sl.registerLazySingleton(
      () => AddUserToContactInfoUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(
      () => GetUsersFromCantactsInfoUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(() => AddGroupToUser(baseUserRepository: sl()));
  sl.registerLazySingleton(() => DeleteGroupFromUser(baseUserRepository: sl()));

  //message usecases
  sl.registerLazySingleton(
      () => SendMessageUseCase(baseMessageRepository: sl()));
  sl.registerLazySingleton(
      () => GetMessagesUseCase(baseMessageRepository: sl()));

  //////////////////////////////////////////////////////////////////////////
  // repositories ///////////////////////////////////////////////////////////

  // group repository
  sl.registerLazySingleton<BaseGroupRepository>(() => GroupRepository(
        baseRemoteGroupDataSource: sl(),
        networkInfo: sl(),
      ));

  // user repository
  sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(
        baseRemoteUserDataSource: sl(),
        networkInfo: sl(),
      ));

  // message repository
  sl.registerLazySingleton<BaseMessageRepository>(() =>
      MessageRepository(baseRemoteMessageDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(baseRemoteAuthDataSource: sl(), networkInfo: sl()));

  //////////////////////////////////////////////////////////////////////////
  // data sources //////////////////////////////////////////////////////////

  // group data source
  sl.registerLazySingleton<BaseRemoteGroupDataSource>(
      () => RemoteGroupDataSource());

  // user data source
  sl.registerLazySingleton<BaseRemoteUserDataSource>(
      () => RemoteUserDataSource());

  // message data source
  sl.registerLazySingleton<BaseRemoteMessageDataSource>(
      () => RemoteMessageDataSource());

  //  auth source
  sl.registerLazySingleton<BaseRemoteAuthDataSource>(
      () => RemoteAuthDataSource());

  //////////////////////////////////////////////////////////////////////////
  // core ////////////////////////////////////////////////////////////

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(internetChecker: sl()));

  //////////////////////////////////////////////////////////////////////////
  // external ////////////////////////////////////////////////////////////

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
