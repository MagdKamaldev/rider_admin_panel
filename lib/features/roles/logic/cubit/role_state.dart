part of 'role_cubit.dart';

sealed class RoleState {}

final class RoleInitial extends RoleState {}

final class GetRoleLoading extends RoleState {}

final class GetRoleSuccess extends RoleState {
  final List<RoleModel> roles;
  GetRoleSuccess(this.roles);
}

final class GetRoleFailure extends RoleState {
  final String message;
  GetRoleFailure(this.message);
}

final class GetPermissionGroupLoading extends RoleState{}

final class GetPermissionGroupSuccess extends RoleState{
  final List<PermissionGroupModel> permissionGroups;
  GetPermissionGroupSuccess(this.permissionGroups);
}

final class GetPermissionGroupFailure extends RoleState {
  final String message;
  GetPermissionGroupFailure(this.message);
}
