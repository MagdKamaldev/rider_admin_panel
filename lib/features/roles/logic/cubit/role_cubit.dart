import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission_group_model.dart';
import 'package:tayar_admin_panel/features/roles/data/models/role_model/role_model.dart';
import 'package:tayar_admin_panel/features/roles/data/repos/roles_repo_impl.dart';
part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  final RolesRepoImpl repo;
  RoleCubit(this.repo) : super(RoleInitial());

  static RoleCubit get(context) => BlocProvider.of(context);

  List<RoleModel> roles = [];

  void getRoles(context) async {
    emit(GetRoleLoading());
    final response = await repo.getRoles();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(GetRoleFailure(l.message));
      },
      (r) {
        roles = r;
        emit(GetRoleSuccess(r));
      },
    );
  }

  List<PermissionGroupModel> groups = [];

  void getGroups(context) async {
  emit(GetPermissionGroupLoading());
  final response = await repo.getPermissionGroups();
  response.fold(
    (l) {
      showErrorSnackbar(context, l.message);
      emit(GetPermissionGroupFailure(l.message));
    },
    (r) {
      groups = r;
      emit(GetPermissionGroupSuccess(r));
    },
  );
}
}
