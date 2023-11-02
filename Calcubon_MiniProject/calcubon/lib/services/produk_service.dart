import 'package:dio/dio.dart';

import '../models/produk.dart';

class ProdukService {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://654323ec01b5e279de1ff07d.mockapi.io'),
  );

  Future<List<Produk>> getProduk() async {
    var response = await dio.get('/produk');
    return (response.data as List).map((e) => Produk.fromJson(e)).toList();
  }
}
