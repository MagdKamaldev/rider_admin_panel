import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
part 'rider_state.dart';

class RiderCubit extends Cubit<RiderState> {
  final RiderRepoImpl repo;
  RiderCubit(this.repo) : super(RiderInitial());
  static  RiderCubit get(context) => BlocProvider.of(context);

  List<RiderModel> riders = [];

  void fetchRiders() async {
    emit(FetchRidersLoading());
    final response = await repo.getRiders();
    response.fold(
      (l) => emit(FetchRidersFailure(l.message)),
      (r) {
        riders = r;
        emit(FetchRidersSuccess(riders));
      },
    );
  }

  void addRider(String name,String nationalId,String phoneNumber,String password) async {
    emit(AddRiderLoading());
    final response = await repo.addRider(name, nationalId, phoneNumber,password);
    response.fold(
      (l) => emit(AddRiderFailure(l.message)),
      (r) {
        riders.add(r);
        emit(AddRiderSuccess(r));
      },
    );
  }

  void updateRider(RiderModel rider) async {
    emit(UpdateRiderLoading());
    final response = await repo.updateRider(rider);
    response.fold(
      (l) => emit(UpdateRiderFailure(l.message)),
      (r) {
        riders[riders.indexWhere((element) => element.id == r.id)] = r;
        emit(UpdateRiderSuccess(r));
      },
    );
  }

  void deleteRider(BuildContext context, int id) async {
    emit(DeleteRiderLoading());
    final response = await repo.deleteRider(id);
    response.fold(
      (l) => emit(DeleteRiderFailure(l.message)),
      (r) {
        emit(DeleteRiderSuccess(r));
      },
    );
  }

  void changeRiderHub(int riderId, int hubId) async {
    emit(ChangeRiderHubLoading());
    final response = await repo.changeRiderHub(riderId, hubId);
    response.fold(
      (l) => emit(ChangeRiderHubFailure(l.message)),
      (r) {
        emit(ChangeRiderHubSuccess(r));
      },
    );
  }

  List<Hub> hubs = [];

  void fetchHubs() async {
    final response = await repo.fetchHubs();
    response.fold(
      (l) => emit(FetchRidersFailure(l.message)),
      (r) {
        hubs = r;
        emit(FetchHubsSuccess(hubs));
      },
    );
  }

  void changeRiderShiftTime(int riderId,DateTime startTime,DateTime endTime,Duration shiftDuration,context) async {
    emit(ChangeRiderShiftTimeLoading());
    final response = await repo.changeRiderShiftTime(riderId, startTime, endTime,shiftDuration);
    response.fold(
      (l) => emit(ChangeRiderShiftTimeFailure(l.message)),
      (r) {
        navigateAndFinish(context, const HomeScreen());
        emit(ChangeRiderShiftTimeSuccess(r));
      },
    );
  }


}
