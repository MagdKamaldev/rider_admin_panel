import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo.dart';

class RiderRepoImpl implements RidersRepo {
  final ApiServices apiServices;
  RiderRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, RiderModel>> deleteRider(int id) async {
    try {
      final response = await apiServices.post(
        data: {"id": id},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.deleteRider,
      );
      return Right(RiderModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RiderModel>>> getRiders() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiConstants.fetchRiders,
        jwt: kTokenBox.get(kTokenBoxString),
      );
      List<RiderModel> riders = [];
      for (var rider in response['data']) {
        riders.add(RiderModel.fromJson(rider));
      }
      return Right(riders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RiderModel>> updateRider(RiderModel rider) {
    // TODO: implement updateRider
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RiderModel>> addRider(String name, String nationalId,
      String mobileNumber, String password) async {
    try {
      final response = await apiServices.post(
        data: {
          "username": name,
          "national_id": nationalId,
          "mobile_number": mobileNumber,
          "password": password,
          "permission": 1,
        },
        jwt: kTokenBox.get(kTokenBoxString).toString(),
        endPoint: ApiConstants.registerUser,
      );
      return Right(RiderModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
