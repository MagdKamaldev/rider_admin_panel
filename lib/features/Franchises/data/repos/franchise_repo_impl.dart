import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Franchises/data/repos/franchise_repo.dart';

class FranchiseRepoImpl extends FranchiseRepo {
  final ApiServices apiServices;
  FranchiseRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, dynamic>> addFranchise(String name) async {
    try {
      final response = await apiServices.post(
        data: {"name": name},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.addFranchise,
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
  Future<Either<Failure, dynamic>> deleteFranchise(int id) async{
    try{
      final response = await apiServices.post(
        data: {"id": id},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.deleteFranchise,
      );
      return Right(response);
      
    }catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<FranchiseModel>>> getFranchises() async {
    try {
      final response = await apiServices.get(
          endPoint: ApiConstants.fetchFranchises,
          jwt: kTokenBox.get(kTokenBoxString));
      var franchiseList = response["data"] as List<dynamic>;
      return Right(franchiseList
          .map<FranchiseModel>((e) => FranchiseModel.fromJson(e))
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
  Future<Either<Failure, dynamic>> updateFranchise(String name, int id) async{
    try{
      final response = await apiServices.post(
        data: {"name": name, "id": id},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.editFranchise,
      );
      return Right(response);
    }catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }


}
