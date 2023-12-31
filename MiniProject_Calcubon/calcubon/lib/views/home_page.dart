import 'package:cached_network_image/cached_network_image.dart';
import 'package:calcubon/blocs/report/report_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/produk_service.dart';
import '../blocs/produk/produk_bloc.dart';
import '../utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = ProdukBloc(produkService: ProdukService())..add(LoadProduk());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => bloc.add(LoadProduk()),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 16.0,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<ProdukBloc, ProdukState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is ProdukLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProdukLoaded) {
                  final data = state.products;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, index) {
                        return GridTile(
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 4.0,
                                ),
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black45,
                                ),
                                child: Text(
                                  '${data[index].co2} co2',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Text(
                              data[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              data[index].description,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<ReportBloc>().add(
                                      CreateReport(
                                        title: data[index].title,
                                        description: data[index].description,
                                        co2: data[index].co2,
                                        image: data[index].image,
                                      ),
                                    );
                                context.read<ReportBloc>().add(LoadReport());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Data berhasil ditambahkan"),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_circle_rounded),
                            ),
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: grey,
                                width: 3,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: data[index].image,
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
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                    ),
                  );
                } else if (state is ProdukError) {
                  return Center(child: Text(state.error));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
