import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/users/data/models/user_model.dart';
import 'package:tayar_admin_panel/features/users/data/repos/users_repo_impl.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepoImpl repo;
  UsersCubit(this.repo) : super(UsersInitial());

  static UsersCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  void getUsers(context) async {
    emit(GetUsersLoading());
    final response = await repo.getUsers();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(GetUsersFailure(l.message));
      },
      (r) {
        users = r;
        emit(GetUsersSuccess(r));
      },
    );
  }
}
