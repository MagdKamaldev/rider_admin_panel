import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/users/data/models/user_model.dart';

abstract class UsersRepo{
  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, dynamic>> addUser(String name, String email, String password, String phone, String address, String role);
  Future<Either<Failure, dynamic>> editUser(int id, String name, String email, String password, String phone, String address, String role);
  Future<Either<Failure, dynamic>> deleteUser(int id);
}