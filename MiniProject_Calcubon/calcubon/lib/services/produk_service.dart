import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/produk.dart';
import '../utils/baseurl.dart';

class ProdukService {
  Future<List<Produk>> getProduk() async {
    var response = await dio.get('/produk');
    return (response.data as List).map((e) => Produk.fromJson(e)).toList();
  }

  Future<List<Produk>> getProdukFirebase({required String token}) async {
    final produkSnapshot =
        await FirebaseFirestore.instance.collection('produk').get();
    return produkSnapshot.docs
        .map(
          (e) => Produk(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            co2: e['co2'],
            image: e['image'],
          ),
        )
        .toList();
  }
}
