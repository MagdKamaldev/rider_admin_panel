part of 'rider_cubit.dart';

sealed class RiderState {}

final class RiderInitial extends RiderState {}

final class FetchRidersLoading extends RiderState {}

final class FetchRidersSuccess extends RiderState {
  final List<RiderModel> riders;
  FetchRidersSuccess(this.riders);
}

final class FetchRidersFailure extends RiderState {
  final String message;
  FetchRidersFailure(this.message);
}

final class AddRiderLoading extends RiderState {}

final class AddRiderSuccess extends RiderState {
  final RiderModel rider;
  AddRiderSuccess(this.rider);
}

final class AddRiderFailure extends RiderState {
  final String message;
  AddRiderFailure(this.message);
}

final class UpdateRiderLoading extends RiderState {}

final class UpdateRiderSuccess extends RiderState {
  final RiderModel rider;
  UpdateRiderSuccess(this.rider);
}

final class UpdateRiderFailure extends RiderState {
  final String message;
  UpdateRiderFailure(this.message);
}

final class DeleteRiderLoading extends RiderState {}

final class DeleteRiderSuccess extends RiderState {
  final RiderModel rider;
  DeleteRiderSuccess(this.rider);
}

final class DeleteRiderFailure extends RiderState {
  final String message;
  DeleteRiderFailure(this.message);
}

final class ChangeRiderHubLoading extends RiderState {}

final class ChangeRiderHubSuccess extends RiderState {
  final RiderModel rider;
  ChangeRiderHubSuccess(this.rider);
}

final class ChangeRiderHubFailure extends RiderState {
  final String message;
  ChangeRiderHubFailure(this.message);
}

final class FetchHubsLoading extends RiderState {}

final class FetchHubsSuccess extends RiderState {
  final List<Hub> hubs;
  FetchHubsSuccess(this.hubs);
}

final class FetchHubsFailure extends RiderState {
  final String message;
  FetchHubsFailure(this.message);
}

final class ChangeRiderShiftTimeLoading extends RiderState {}

final class ChangeRiderShiftTimeSuccess extends RiderState {
  final RiderModel rider;
  ChangeRiderShiftTimeSuccess(this.rider);
}

final class ChangeRiderShiftTimeFailure extends RiderState {
  final String message;
  ChangeRiderShiftTimeFailure(this.message);
}