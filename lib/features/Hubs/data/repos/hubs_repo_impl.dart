import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';

class HubsRepoImpl implements HubsRepo {
  final ApiServices apiServices;
  HubsRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, dynamic>> deleteHub(int id) async{
    try{
       final response = await apiServices.post(
         data: {"id": id},
         jwt: kTokenBox.get(kTokenBoxString),
         endPoint: ApiConstants.deleteHub,
       );
       return Right(Hub.fromJson(response));
    }catch (e) {
       if (e is DioException) {
         return Left(ServerFailure.fromDioError(e));
       } else {
         return Left(ServerFailure(e.toString()));
       }
     }
    
  }

  @override
  Future<Either<Failure, List<Hub>>> getHubs() async {
    try {
      final response = await apiServices.get(
          endPoint: "admin/FetchHubs", jwt: kTokenBox.get(kTokenBoxString));
      var hubsList = response["data"] as List<dynamic>;
      return Right(hubsList.map<Hub>((e) => Hub.fromJson(e)).toList());
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
  Future<Either<Failure, dynamic>> createHub(String name, int managerId) async {
    try {
      final response = await apiServices.post(
        data: {"name": name, "manager_id": managerId},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.addHub,
      );
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Hub>> getHub(int id) async {
    try {
      final response = await apiServices.post(
        data: {"id": id},
          endPoint: ApiConstants.fetchHub, jwt: kTokenBox.get(kTokenBoxString));
      Hub hub = Hub.fromJson(response["data"]);
      return Right(hub);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
  
  @override
  Future<Either<Failure, dynamic>> updateHub(String name, int managerId, int id) async{
    try {
      final response = await apiServices.post(
        data: {"name": name, "manager_id": managerId, "id": id},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.editHub,
      );
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
