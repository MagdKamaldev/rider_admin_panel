import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/networks/api_constants.dart';
import 'package:tayar_admin_panel/core/networks/api_services.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission_group_model.dart';
import 'package:tayar_admin_panel/features/roles/data/models/role_model/role_model.dart';
import 'package:tayar_admin_panel/features/roles/data/roles_repo.dart';

class RolesRepoImpl extends RolesRepo {
  final ApiServices apiServices;
  RolesRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, List<RoleModel>>> getRoles() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiConstants.fetchRoles,
        jwt: kTokenBox.get(kTokenBoxString),
      );
      List<RoleModel> roles = [];
      for (var role in response['data']) {
        roles.add(RoleModel.fromJson(role));
      }
      return Right(roles);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PermissionGroupModel>>>
      getPermissionGroups() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiConstants.fetchPermissionGroups,
        jwt: kTokenBox.get(kTokenBoxString),
      );
      List<PermissionGroupModel> groups = [];
      for (var group in response['data']) {
        groups.add(PermissionGroupModel.fromJson(group));
      }
      return Right(groups);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addRoles(String name, List<int> ids) async {
    final permissions = ids.map((id) => {"ID": id}).toList();
    final data = {
      "name": name,
      "permissions": permissions,
    };
    try {
      final response = await apiServices.post(
          endPoint: ApiConstants.createRole,
          data: data,
          jwt: kTokenBox.get(kTokenBoxString));
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> editRole(
      int id, String name, List<int> ids) async {
    final permissions = ids.map((id) => {"ID": id}).toList();
    final data = {
      "ID": id,
      "name": name,
      "permissions": permissions,
    };
    try {
      final response = await apiServices.post(
          endPoint: ApiConstants.editRole,
          data: data,
          jwt: kTokenBox.get(kTokenBoxString));
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, dynamic>> assignUserToRole(int userId, int roleId) async{
    final data = {
      "user_id": userId,
      "role_id": roleId,
    };
    try {
      final response = await apiServices.post(
          endPoint: ApiConstants.assignUserRole,
          data: data,
          jwt: kTokenBox.get(kTokenBoxString));
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
