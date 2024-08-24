import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission_group_model.dart';
import 'package:tayar_admin_panel/features/roles/data/models/role_model/role_model.dart';

abstract class RolesRepo {
  Future<Either<Failure, List<RoleModel>>> getRoles();
  Future<Either<Failure, List<PermissionGroupModel>>> getPermissionGroups();
  Future<Either<Failure, dynamic>> addRoles(String name, List<int> ids);
  Future<Either<Failure, dynamic>> editRole(int id, String name, List<int> ids);
}
