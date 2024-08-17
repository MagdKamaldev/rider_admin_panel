part of 'branch_cubit.dart';

@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}

final class GetBranchDataLoading extends BranchState {}

final class GetBranchDataSuccess extends BranchState {}

final class GetBranchDataFailed extends BranchState {
  final String message;

  GetBranchDataFailed(this.message);
}

final class AddBranchLoadingState extends BranchState {}

final class AddBranchSuccessState extends BranchState {}

final class AddBranchErrorState extends BranchState {
  final String message;

  AddBranchErrorState(this.message);
}

final class GetBranchesLoading extends BranchState {}

final class GetBranchesSuccess extends BranchState {
  final List<BranchModel> branches;

  GetBranchesSuccess(this.branches);
}

final class GetBranchesError extends BranchState {
  final String message;
  GetBranchesError(this.message);
}

final class DeleteBranchLoading extends BranchState {}

final class DeleteBranchSuccess extends BranchState {}

final class DeleteBranchError extends BranchState {
  final String message;
  DeleteBranchError(this.message);
}

final class UpdateBranchLoading extends BranchState {}

final class UpdateBranchSuccess extends BranchState {}

final class UpdateBranchError extends BranchState {
  final String message;
  UpdateBranchError(this.message);
}
