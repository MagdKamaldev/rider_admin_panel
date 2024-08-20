// ignore_for_file: void_checks

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/branch_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';

class BranchRepoImpl implements BranchRepo {
  final ApiServices apiServices;
  BranchRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, BranchResponse>> getBranchData() async {
    try {
      final response = await apiServices.get(
          endPoint: ApiConstants.fetchBranchData,
          jwt: kTokenBox.get(kTokenBoxString).toString());
      var franchiseList = response["franchises"] as List<dynamic>;
      var hubList = response["hubs"] as List<dynamic>;

      return Right(BranchResponse(
          franchises: franchiseList.map((e) {
            return FranchiseModel.fromJson(e);
          }).toList(),
          hubs: hubList.map((e) {
            return Hub.fromJson(e);
          }).toList()));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> addShopBranch(
      String name, String address, int hubId, int franchiseId,double lat,double lng) async {
    try {
      final response = await apiServices.post(
          endPoint: ApiConstants.addBranch,
          data: {
            "name": name,
            "address": address,
            "hub_id": hubId,
            "franchise_id": franchiseId,
            "lat":lat,
            "lng":lng
          },
          jwt: kTokenBox.get(kTokenBoxString).toString());
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
  Future<Either<Failure, List<BranchModel>>> getBranches() async {
    try {
      final response = await apiServices.get(
          endPoint: ApiConstants.fetchBranches,
          jwt: kTokenBox.get(kTokenBoxString).toString());
      return Right((response['data'] as List<dynamic>)
          .map((e) => BranchModel.fromJson(e))
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
  Future<Either<Failure, void>> deleteBranch(int id) async{
    try{
      final response = await apiServices.post(
        data: {"id": id},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.deleteBranch,
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
  Future<Either<Failure, void>> updateBranch(int id, String name, String address, int hubId, int franchiseId,double lat,double lng) async{
    try{
      final response = await apiServices.post(
        data: {
          "id": id,
          "name": name,
          "address": address,
          "hub_id": hubId,
          "franchise_id": franchiseId,
          "lat":lat,
          "lng":lng
        },
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.editBranch,
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
