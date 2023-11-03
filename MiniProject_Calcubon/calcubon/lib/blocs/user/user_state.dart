part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserSignedOut extends UserState {}

final class UserSignedIn extends UserState {
  final UserModel user;
  const UserSignedIn(this.user);
  @override
  List<Object> get props => [user];
}
