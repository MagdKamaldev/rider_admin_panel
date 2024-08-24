import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/users/data/models/user_model.dart';
import 'package:tayar_admin_panel/features/users/data/repos/users_repo.dart';

class UsersRepoImpl implements UsersRepo {
  final ApiServices apiServices;

  UsersRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, dynamic>> addUser(String name, String email,
      String password, String phone, String address, String role) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> editUser(int id, String name, String email,
      String password, String phone, String address, String role) {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
   // try {
      final response = await apiServices.get(
        endPoint: ApiConstants.fetchUsers,
        jwt: kTokenBox.get(kTokenBoxString),
      );
      List<UserModel> users = [];
      for (var user in response['data']) {
        users.add(UserModel.fromJson(user));
      }
      return Right(users);
    //} catch (e) {
   //   if (e is DioException) {
    //    return Left(ServerFailure.fromDioError(e));
    //  } else {
    //    return Left(ServerFailure(e.toString()));
    //  }
  //  }
  }
}
