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
