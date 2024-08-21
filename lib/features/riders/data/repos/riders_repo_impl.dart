import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model/rider_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo.dart';

class RiderRepoImpl implements RidersRepo {
  final ApiServices apiServices;
  RiderRepoImpl({required this.apiServices});

  String _formatDateTimeWithOffset(DateTime dateTime) {
    final duration = dateTime.timeZoneOffset;
    final hours = duration.inHours.abs().toString().padLeft(2, '0');
    final minutes = (duration.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final sign = duration.isNegative ? '-' : '+';
    final formattedOffset = '$sign$hours:$minutes';

    return "${dateTime.toIso8601String().split('.').first}$formattedOffset";
  }

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

  @override
  Future<Either<Failure, RiderModel>> changeRiderHub(
      int riderId, int hubId) async {
    try {
      final response = await apiServices.post(
        data: {"rider_id": riderId, "hub_id": hubId},
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.editRiderHub,
      );
      return Right(RiderModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Hub>>> fetchHubs() async {
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
  Future<Either<Failure, RiderModel>> changeRiderShiftTime(int riderId,
      DateTime startTime, DateTime endTime, Duration shiftDuration) async {
    try {
      final response = await apiServices.post(
        data: {
          "rider_id": riderId,
          "open_at": _formatDateTimeWithOffset(startTime),
          "close_at": _formatDateTimeWithOffset(endTime),
          "duration": shiftDuration.inSeconds,
        },
        jwt: kTokenBox.get(kTokenBoxString),
        endPoint: ApiConstants.editRiderShiftTime,
      );
      return Right(RiderModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
