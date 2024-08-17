part of 'managers_cubit.dart';

@immutable
sealed class ManagersState {}

final class ManagersInitial extends ManagersState {}

class AddManagerLoadinState extends ManagersState {}

class AddManagerSuccessState extends ManagersState {}

class AddManagerErrorState extends ManagersState {
  final String error;
  AddManagerErrorState(this.error);
}

class FetchManagersLoading extends ManagersState {}

class FetchManagersSuccess extends ManagersState {
  final List<ManagerModel> managers;
  FetchManagersSuccess(this.managers);
}

class FetchManagersError extends ManagersState {
  final String error;
  FetchManagersError(this.error);
}

class UpdateManagerLoading extends ManagersState {}

class UpdateManagerSuccess extends ManagersState {}

class UpdateManagerError extends ManagersState {
  final String error;
  UpdateManagerError(this.error);
}

class DeleteManagerLoading extends ManagersState {}

class DeleteManagerSuccess extends ManagersState {}

class DeleteManagerError extends ManagersState {
  final String error;
  DeleteManagerError(this.error);
}
