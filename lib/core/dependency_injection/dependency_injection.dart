import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  // controllers
  sl.registerFactory(() => GroupController(
      createGroupUseCase: sl(),
      updateGroupUseCase: sl(),
      addUsersGroupUseCase: sl(),
      getAllGroupsUseCase: sl()));

  sl.registerFactory(() => UserController(
      getUserInfo: sl(),
      signUpUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
      addUserToContactInfoUseCase: sl(),
      getUsersFromCantactsInfoUseCase: sl(),
      addGroupToUser: sl(),
      deleteGroupFromUser: sl()));

  sl.registerFactory(() =>
      MessageController(sendMessageUseCase: sl(), getMessagesUseCase: sl()));
  ////////////////////////////////////////////////////
  // usecases
  sl.registerLazySingleton(() => CreateGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(() => UpdateGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(
      () => AddUsersGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllGroupsUseCase(baseGroupRepository: sl()));

  sl.registerLazySingleton(() => SignUpUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(baseUserRepository: sl()));

  sl.registerLazySingleton(
      () => AddUserToContactInfoUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(
      () => GetUsersFromCantactsInfoUseCase(baseUserRepository: sl()));

  sl.registerLazySingleton(() => AddGroupToUser(baseUserRepository: sl()));
  sl.registerLazySingleton(() => DeleteGroupFromUser(baseUserRepository: sl()));

  sl.registerLazySingleton(
      () => SendMessageUseCase(baseMessageRepository: sl()));
  sl.registerLazySingleton(
      () => GetMessagesUseCase(baseMessageRepository: sl()));

  sl.registerLazySingleton(() => GetUserInfo(baseUserRepository: sl()));

////////////////////////////////////////////////////////
// // repositories
  sl.registerLazySingleton<BaseGroupRepository>(() => GroupRepository(
        baseRemoteGroupDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(
        baseRemoteUserDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<BaseMessageRepository>(() =>
      MessageRepository(baseRemoteMessageDataSource: sl(), networkInfo: sl()));

  ////////////////////////////////////////////////////////
// data sources
  sl.registerLazySingleton<BaseRemoteGroupDataSource>(
      () => RemoteGroupDataSource());

  sl.registerLazySingleton<BaseRemoteUserDataSource>(
      () => RemoteUserDataSource());

  sl.registerLazySingleton<BaseRemoteMessageDataSource>(
      () => RemoteMessageDataSource());
  //core /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(internetChecker: sl()));

  //external /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
