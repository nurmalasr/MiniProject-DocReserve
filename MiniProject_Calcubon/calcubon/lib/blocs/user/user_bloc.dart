import 'package:bloc/bloc.dart';
import 'package:calcubon/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserSignedOut()) {
    on<SignIn>((event, emit) async {
      if (state is UserSignedOut) {
        String? token = await UserService.getToken(
          email: event.email,
          password: event.password,
        );

        if (token != null) {
          UserModel? user = await UserService.getUser(token: token);
          if (user != null) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('token', token);
            emit(UserSignedIn(user));
          }
        }
      }
    });

    on<SignOut>((event, emit) async {
      if (state is UserSignedIn) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('token');
        emit(UserSignedOut());
      }
    });

    on<CheckSignInStatus>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');

      if (token != null) {
        bool tokenValid = await UserService.isTokenValid();
        if (tokenValid) {
          UserModel? user = await UserService.getUser(token: token);
          if (user != null) {
            emit(UserSignedIn(user));
          }
        }
      }
    });

    on<UpdateUser>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      UserService.editUser(
        token: token!,
        fullname: event.fullname,
        tglLahir: event.tglLahir,
        location: event.location,
      );
    });
  }
}
