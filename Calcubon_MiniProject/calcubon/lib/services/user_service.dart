import 'package:dio/dio.dart';

import '../models/user.dart';

class UserService {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://654323ec01b5e279de1ff07d.mockapi.io'),
  );

  Future<List<User>> getUser() async {
    var response = await dio.get('/user');
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }
}
