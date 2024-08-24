part of 'users_cubit.dart';

sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class GetUsersLoading extends UsersState {}

final class GetUsersSuccess extends UsersState {
  final List<UserModel> users;
  GetUsersSuccess(this.users);
}

final class GetUsersFailure extends UsersState {
  final String message;
  GetUsersFailure(this.message);
}
