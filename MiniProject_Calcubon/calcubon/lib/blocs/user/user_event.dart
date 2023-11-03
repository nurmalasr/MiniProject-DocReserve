part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends UserEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends UserEvent {}

class CheckSignInStatus extends UserEvent {}

final class UpdateUser extends UserEvent {
  final String fullname;
  final String tglLahir;
  final String location;

  const UpdateUser({
    required this.fullname,
    required this.tglLahir,
    required this.location,
  });
}
