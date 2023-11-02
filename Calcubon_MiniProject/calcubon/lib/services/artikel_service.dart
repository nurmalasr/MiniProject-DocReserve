import 'package:dio/dio.dart';

import '../models/artikel.dart';

class ArtikelService {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://654323ec01b5e279de1ff07d.mockapi.io'),
  );

  Future<List<Artikel>> getArtikel() async {
    var response = await dio.get('/artikel');
    return (response.data as List).map((e) => Artikel.fromJson(e)).toList();
  }
}
