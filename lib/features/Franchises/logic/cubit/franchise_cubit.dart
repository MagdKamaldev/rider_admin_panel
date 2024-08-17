import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Franchises/data/repos/franchise_repo_impl.dart';
part 'franchise_state.dart';

class FranchiseCubit extends Cubit<FranchiseState> {
  final FranchiseRepoImpl repo;
  FranchiseCubit(this.repo) : super(FranchiseInitial());

  static FranchiseCubit get(context) => BlocProvider.of(context);

  List<FranchiseModel> franchises = [];

  void fetchFranchises(BuildContext context) async {
    emit(GetFranchiseDataLoading());
    final response = await repo.getFranchises();
    response.fold(
      (l) {
        emit(GetFranchiseDataFailed(l.message));
      },
      (r) {
        franchises = r;
        emit(GetFranchiseDataSuccess(r));
      },
    );
  }

  void addFranchise(BuildContext context, String name) async {
    emit(AddFranchiseLoadingState());
    final response = await repo.addFranchise(name);
    response.fold(
      (l) {
        emit(AddFranchiseErrorState(l.message));
      },
      (r) {
        emit(AddFranchiseSuccessState());
      },
    );
  }

  void updateFranchise(BuildContext context, String name, int id) async {
    emit(UpdateFranchiseLoading());
    final response = await repo.updateFranchise(name, id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(UpdateFranchiseError(l.message));
      },
      (r) {
        emit(UpdateFranchiseSuccess());
      },
    );
  }

  void deleteFranchise(BuildContext context, int id) async {
    emit(DeleteFranchiseLoading());
    final response = await repo.deleteFranchise(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(DeleteFranchiseError(l.message));
      },
      (r) {
        emit(DeleteFranchiseSuccess());
      },
    );
  }
}
