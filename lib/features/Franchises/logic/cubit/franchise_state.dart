part of 'franchise_cubit.dart';

@immutable
sealed class FranchiseState {}

final class FranchiseInitial extends FranchiseState {}

final class GetFranchiseDataLoading extends FranchiseState {}

final class GetFranchiseDataSuccess extends FranchiseState {
  final List<FranchiseModel> franchises;

  GetFranchiseDataSuccess(this.franchises);
}

final class GetFranchiseDataFailed extends FranchiseState {
  final String message;

  GetFranchiseDataFailed(this.message);
}

final class AddFranchiseLoadingState extends FranchiseState {}

final class AddFranchiseSuccessState extends FranchiseState {}

final class AddFranchiseErrorState extends FranchiseState {
  final String message;

  AddFranchiseErrorState(this.message);
}

final class DeleteFranchiseLoading extends FranchiseState {}

final class DeleteFranchiseSuccess extends FranchiseState {}

final class DeleteFranchiseError extends FranchiseState {
  final String message;

  DeleteFranchiseError(this.message);
}
