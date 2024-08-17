import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/branch_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo_impl.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchRepoImpl repo;
  BranchCubit(this.repo) : super(BranchInitial());

  static BranchCubit get(context) => BlocProvider.of(context);
  List<FranchiseModel> franchises = [];
  List<Hub> hubs = [];

  void getBranchData(BuildContext context) async {
    emit(GetBranchDataLoading());
    final response = await repo.getBranchData();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(GetBranchDataFailed(l.message));
      },
      (r) {
        franchises = r.franchises;
        hubs = r.hubs;
        emit(GetBranchDataSuccess());
      },
    );
  }

  void addBranch(BuildContext context, String name, String address, int hubId,
      int franchiseId) async {
    emit(AddBranchLoadingState());
    final response =
        await repo.addShopBranch(name, address, hubId, franchiseId);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(AddBranchErrorState(l.message));
      },
      (r) {
        showErrorSnackbar(context, "Success");
        emit(AddBranchSuccessState());
      },
    );
  }

  List<BranchModel> branches = [];

  void fetchBranches(BuildContext context) async {
    emit(GetBranchesLoading());
    final response = await repo.getBranches();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(GetBranchesError(l.message));
      },
      (r) {
        branches = r;
        emit(GetBranchesSuccess(r));
      },
    );
  }

  void deleteBranch(BuildContext context, int id) async {
    emit(DeleteBranchLoading());
    final response = await repo.deleteBranch(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(DeleteBranchError(l.message));
      },
      (r) {
        emit(DeleteBranchSuccess());
      },
    );
  }
}
