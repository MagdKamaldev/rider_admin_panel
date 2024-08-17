import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/repos/managers_repo.dart';

class ManagersRepoImpl implements ManagersRepo {
  final ApiServices apiServices;
  ManagersRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, dynamic>> addManager(
      String name, String password) async {
    try {
      final response = await apiServices.post(
        data: {"username": name, "password": password, "permission": 3},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.registerUser,
      );
      return Right(ManagerModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ManagerModel>> deleteManager(int id) async {
    try {
      final response = await apiServices.post(
        data: {"id": id},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.deleteManager,
      );
      return Right(ManagerModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ManagerModel>>> getManagers() async {
    try {
      final response = await apiServices.get(
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.fetchManagers,
      );
      return Right((response)['data']
          .map<ManagerModel>((e) => ManagerModel.fromJson(e))
          .toList());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ManagerModel>> updateManager(
      String name, String password, int id) async {
    try {
      final response = await apiServices.post(
        data: {
          "username": name,
          "password": password,
          "permission": 3,
          "id": id
        },
        jwt: kTokenBox.get(kTokenBoxString).toString(),
        endPoint: ApiConstants.updateUser,
      );
      return Right(ManagerModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
