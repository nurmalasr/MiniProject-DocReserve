import 'package:cached_network_image/cached_network_image.dart';

import '../../models/artikel.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailArticlePage extends StatelessWidget {
  final Artikel artikel;
  const DetailArticlePage({super.key, required this.artikel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_outlined),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            artikel.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${artikel.author} - ${DateFormat('dd/MM/yy').format(
              DateTime.parse(artikel.createdAt),
            )}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: grey,
                width: 3,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: artikel.image,
              placeholder: (context, url) => const Icon(
                Icons.article_outlined,
                size: 30,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.article_outlined,
                size: 30,
              ),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            artikel.body,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: grey,
            ),
          ),
        ],
      ),
    );
  }
}
