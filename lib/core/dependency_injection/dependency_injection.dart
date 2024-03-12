import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_cli_test/features/group/domain_layer/repository.dart';
import 'package:my_cli_test/features/group/domain_layer/use_cases.dart';
import 'package:my_cli_test/features/group/presentaion_layer/group_controller.dart';
import 'package:my_cli_test/features/user/data_layer/data_source.dart';
import 'package:my_cli_test/features/user/data_layer/repository.dart';
import 'package:my_cli_test/features/user/domain_layer/repository.dart';
import 'package:my_cli_test/features/user/domain_layer/use_cases.dart';
import 'package:my_cli_test/features/user/presentaion_layer/controller.dart';

import '../../features/group/data_layer/data_source.dart';
import '../../features/group/data_layer/repository.dart';
import '../network_info/network_info.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //////////////////////////////////////////////////////////////////////////
  // controllers
  sl.registerFactory(() => GroupController(
        createGroupUseCase: sl(),
        renameGroupUseCase: sl(),
      ));

  sl.registerFactory(() => UserController(
      signUpUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
      addUserToContactInfoUseCase: sl(),
      getUsersFromCantactsInfoUseCase: sl(),
      addUsersToGroup: sl(),
      deleteUserFromGroup: sl()));
  ////////////////////////////////////////////////////
  // usecase
  sl.registerLazySingleton(() => CreateGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(() => RenameGroupUseCase(baseGroupRepository: sl()));

  sl.registerLazySingleton(() => SignUpUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(baseUserRepository: sl()));

  sl.registerLazySingleton(
      () => AddUserToContactInfoUseCase(baseUserRepository: sl()));
  sl.registerLazySingleton(
      () => GetUsersFromCantactsInfoUseCase(baseUserRepository: sl()));

  sl.registerLazySingleton(() => AddUsersToGroup(baseUserRepository: sl()));
  sl.registerLazySingleton(() => DeleteUserFromGroup(baseUserRepository: sl()));

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
  ////////////////////////////////////////////////////////
// data sources
  sl.registerLazySingleton<BaseRemoteGroupDataSource>(
      () => RemotePostDataSource());

  sl.registerLazySingleton<BaseRemoteUserDataSource>(
      () => RemoteUserDataSource());

  //core /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(internetChecker: sl()));

  //external /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
