import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/login/data/repos/login_repo.dart';
import 'package:tayar_admin_panel/main.dart';

class LoginRepositoryImpelemntation implements LoginRepo {
  final ApiServices apiServices;
  LoginRepositoryImpelemntation({required this.apiServices});
  @override
  Future<Either<Failure, String>> login(
      String username, String password) async {
    try {
      final response = await apiServices.post(
        data: {"username": username, "password": password},
        endPoint: ApiConstants.login,
      );

      token = response["jwt"];
      kTokenBox.put(kTokenBoxString, token);
      if (response["permission"] == 4) {
        return Right(response["jwt"]);
      } else {
        return Left(ServerFailure("You are not allowed to login "));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
