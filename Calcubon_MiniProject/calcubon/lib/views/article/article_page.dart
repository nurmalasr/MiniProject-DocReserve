import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'detail_article_page.dart';
import '../../blocs/artikel/artikel_bloc.dart';
import '../../services/artikel_service.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = ArtikelBloc(artikelService: ArtikelService())
      ..add(LoadArtikel());
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: Text(
              'Article',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<ArtikelBloc, ArtikelState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ArtikelLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ArtikelLoaded) {
                final data = state.artikels;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailArticlePage(
                              artikel: data[index],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            data[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                data[index].title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yy').format(
                                DateTime.parse(data[index].createdAt),
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        subtitle: Text(data[index].slug),
                      ),
                    );
                  },
                );
              } else if (state is ArtikelError) {
                return Center(child: Text(state.error));
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}