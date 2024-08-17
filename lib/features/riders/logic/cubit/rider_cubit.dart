import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
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
}
