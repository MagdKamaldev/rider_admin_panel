import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/repos/managers_repo_impl.dart';

part 'managers_state.dart';

class ManagersCubit extends Cubit<ManagersState> {
  final ManagersRepoImpl repoImpl;
  ManagersCubit(this.repoImpl) : super(ManagersInitial());
  static ManagersCubit get(context) => BlocProvider.of(context);

  void addManager(BuildContext context, String name, String password) async {
    emit(AddManagerLoadinState());
    final response = await repoImpl.addManager(name, password);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(AddManagerErrorState(l.message));
      },
      (r) {
        emit(AddManagerSuccessState());
      },
    );
  }

  List<ManagerModel> managers = [];

  void fetchManagers(BuildContext context) async {
    emit(FetchManagersLoading());
    final response = await repoImpl.getManagers();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(FetchManagersError(l.message));
      },
      (r) {
        managers = r;
        emit(FetchManagersSuccess(r));
      },
    );
  }

  void updateManager(BuildContext context,String name,String password,int id) async {
    emit(UpdateManagerLoading());
    final response = await repoImpl.updateManager(name,password,id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(UpdateManagerError(l.message));
      },
      (r) {
        emit(UpdateManagerSuccess());
      },
    );
  }

  void deleteManager(BuildContext context, int id) async {
    emit(DeleteManagerLoading());
    final response = await repoImpl.deleteManager(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(DeleteManagerError(l.message));
      },
      (r) {
        emit(DeleteManagerSuccess());
      },
    );
  }
}
