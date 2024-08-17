import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/login/data/repos/login_repo_impl.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepositoryImpelemntation repoImpl;
  LoginCubit(this.repoImpl) : super(LoginInitial());

  void login(BuildContext context, String name, String password) async {
    emit(LoginLoadingState());
    final response = await repoImpl.login(name, password);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(LoginErrorState(l.message));
      },
      (r) {
        emit(LoginSuccessState(r));
      },
    );
  }
}
