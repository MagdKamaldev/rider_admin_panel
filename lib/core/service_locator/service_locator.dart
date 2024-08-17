import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo_impl.dart';
import 'package:tayar_admin_panel/features/Franchises/data/repos/franchise_repo_impl.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Managers/data/repos/managers_repo_impl.dart';
import 'package:tayar_admin_panel/features/login/data/repos/login_repo_impl.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(
      Dio(),
    ),
  );
  getIt.registerLazySingleton<LoginRepositoryImpelemntation>(
    () => LoginRepositoryImpelemntation(
      apiServices: getIt<ApiServices>(),
    ),
  );
  getIt.registerLazySingleton<ManagersRepoImpl>(
    () => ManagersRepoImpl(
      apiServices: getIt<ApiServices>(),
    ),
  );

  getIt.registerLazySingleton<BranchRepoImpl>(
    () => BranchRepoImpl(
      apiServices: getIt<ApiServices>(),
    ),
  );

  getIt.registerLazySingleton<FranchiseRepoImpl>(
    () => FranchiseRepoImpl(
      apiServices: getIt<ApiServices>(),
    ),
  );

  getIt.registerLazySingleton<HubsRepoImpl>(
    () => HubsRepoImpl(
      apiServices: getIt<ApiServices>(),
    ),
  );
}
