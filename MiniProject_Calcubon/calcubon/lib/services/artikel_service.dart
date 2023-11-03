import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/artikel.dart';
import '../utils/baseurl.dart';

class ArtikelService {
  Future<List<Artikel>> getArtikel() async {
    var response = await dio.get('/artikel');
    return (response.data as List).map((e) => Artikel.fromJson(e)).toList();
  }

  Future<List<Artikel>> getArtikelFirebase({required String token}) async {
    final artikelSnapshot =
        await FirebaseFirestore.instance.collection('artikel').get();
    return artikelSnapshot.docs
        .map(
          (e) => Artikel(
            id: e['id'],
            title: e['title'],
            slug: e['slug'],
            body: e['body'],
            author: e['author'],
            image: e['image'],
            createdAt: e['createdAt'],
          ),
        )
        .toList();
  }
}
