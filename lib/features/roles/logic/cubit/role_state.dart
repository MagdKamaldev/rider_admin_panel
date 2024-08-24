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

final class GetPermissionGroupLoading extends RoleState {}

final class GetPermissionGroupSuccess extends RoleState {
  final List<PermissionGroupModel> permissionGroups;
  GetPermissionGroupSuccess(this.permissionGroups);
}

final class GetPermissionGroupFailure extends RoleState {
  final String message;
  GetPermissionGroupFailure(this.message);
}

final class AddRoleLoading extends RoleState {}

final class AddRoleSuccess extends RoleState {}

final class AddRoleFailure extends RoleState {
  final String message;
  AddRoleFailure(this.message);
}

final class EditRoleLoading extends RoleState {}

final class EditRoleSuccess extends RoleState {}

final class EditRoleFailure extends RoleState {
  final String message;
  EditRoleFailure(this.message);
}

final class AssignUserToRoleLoading extends RoleState {}

final class AssignUserToRoleSuccess extends RoleState {}

final class AssignUserToRoleFailure extends RoleState {
  final String message;
  AssignUserToRoleFailure(this.message);
}
