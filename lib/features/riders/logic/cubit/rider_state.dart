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