part of 'hub_cubit.dart';

sealed class HubState {}

final class HubInitial extends HubState {}

final class FetchHubsLoading extends HubState {}

final class FetchHubsSuccess extends HubState {
  final List<Hub> hubs;
  FetchHubsSuccess(this.hubs);
}

final class FetchHubsFailed extends HubState {
  final String error;
  FetchHubsFailed(this.error);
}

final class CreateHubLoading extends HubState {}

final class CreateHubSuccess extends HubState {}

final class CreateHubFailed extends HubState {
  final String error;
  CreateHubFailed(this.error);
}

class FetchManagersLoading extends HubState {}

class FetchManagersSuccess extends HubState {
  final List<ManagerModel> managers;
  FetchManagersSuccess(this.managers);
}

class FetchManagersError extends HubState {
  final String error;
  FetchManagersError(this.error);
}

class FetchHubLoading extends HubState {}

class FetchHubSuccess extends HubState {
  final Hub hub;
  FetchHubSuccess(this.hub);
}

class FetchHubFailed extends HubState {
  final String error;
  FetchHubFailed(this.error);
}

class UpdateHubLoading extends HubState {}

class UpdateHubSuccess extends HubState {}

class UpdateHubFailed extends HubState {
  final String error;
  UpdateHubFailed(this.error);
}

class DeleteHubLoading extends HubState {}

class DeleteHubSuccess extends HubState {}

class DeleteHubFailed extends HubState {
  final String error;
  DeleteHubFailed(this.error);
}
