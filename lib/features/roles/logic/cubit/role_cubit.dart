import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
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

  Future getGroups(context) async {
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

  void addRole(context, String name, List<int> ids) async {
    emit(AddRoleLoading());
    final response = await repo.addRoles(name, ids);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(AddRoleFailure(l.message));
      },
      (r) {
        navigateAndFinish(context, const HomeScreen());
        emit(AddRoleSuccess());
      },
    );
  }

  void editRole(context, int id, String name, List<int> ids) async {
    emit(EditRoleLoading());
    final response = await repo.editRole(id, name, ids);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(EditRoleFailure(l.message));
      },
      (r) {
        navigateAndFinish(context, const HomeScreen());
        emit(EditRoleSuccess());
      },
    );
  }

  void assignUserToRole(context, int userId, int roleId)
  {
    emit(AssignUserToRoleLoading());
    repo.assignUserToRole(userId, roleId).then((value) {
      value.fold(
        (l) {
          showErrorSnackbar(context, l.message);
          emit(AssignUserToRoleFailure(l.message));
        },
        (r) {
          navigateAndFinish(context, const HomeScreen());
          emit(AssignUserToRoleSuccess());
        },
      );
    });
  }
}
