import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_cli_test/features/group/domain_layer/repository.dart';
import 'package:my_cli_test/features/group/domain_layer/use_cases.dart';
import 'package:my_cli_test/features/group/presentaion_layer/group_controller.dart';

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

  ////////////////////////////////////////////////////
  // usecase
  sl.registerLazySingleton(() => CreateGroupUseCase(baseGroupRepository: sl()));
  sl.registerLazySingleton(() => RenameGroupUseCase(baseGroupRepository: sl()));

////////////////////////////////////////////////////////
// // repositories
  sl.registerLazySingleton<BaseGroupRepository>(() => GroupRepository(
        baseRemoteGroupDataSource: sl(),
        networkInfo: sl(),
      ));

  ////////////////////////////////////////////////////////
// data sources
  sl.registerLazySingleton<BaseRemoteGroupDataSource>(
      () => RemotePostDataSource());

  //core /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(internetChecker: sl()));

  //external /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
