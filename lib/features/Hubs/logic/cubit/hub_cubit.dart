import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';
part 'hub_state.dart';

class HubCubit extends Cubit<HubState> {
  final HubsRepoImpl repo;
  HubCubit(this.repo) : super(HubInitial());

  static HubCubit get(context) => BlocProvider.of(context);

  List<Hub> hubs = [];

  void fetchHubs(BuildContext context) async {
    emit(FetchHubsLoading());
    final response = await repo.getHubs();
    response.fold(
      (l) {
        emit(FetchHubsFailed(l.message));
      },
      (r) {
        hubs = r;
        emit(FetchHubsSuccess(r));
      },
    );
  }

  List<ManagerModel> managers = [];

  void fetchManagers(BuildContext context) async {
    emit(FetchManagersLoading());
    final response = await repo.getManagers();
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

  void createHub(BuildContext context, String name, int managerId) async {
    emit(CreateHubLoading());
    final response = await repo.createHub(name, managerId);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(CreateHubFailed(l.message));
      },
      (r) {
        emit(CreateHubSuccess());
      },
    );
  }

  Hub? hub;

  void fetchHub(BuildContext context, int id) async {
    emit(FetchHubLoading());
    final response = await repo.getHub(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(FetchHubFailed(l.message));
      },
      (r) {
        hub = r;
        emit(FetchHubSuccess(r));
      },
    );
  }

  void updateHub(BuildContext context, String name, int managerID, int id) async {
    emit(UpdateHubLoading());
    final response = await repo.updateHub(name,managerID,id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(UpdateHubFailed(l.message));
      },
      (r) {
        emit(UpdateHubSuccess());
      },
    );
  }

  void deleteHub(BuildContext context, int id) async {
    emit(DeleteHubLoading());
    final response = await repo.deleteHub(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(DeleteHubFailed(l.message));
      },
      (r) {
        emit(DeleteHubSuccess());
      },
    );
  }
}
