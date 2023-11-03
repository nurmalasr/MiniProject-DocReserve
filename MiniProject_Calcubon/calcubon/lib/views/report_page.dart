import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/report/report_bloc.dart';
import '../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async => context.read<ReportBloc>().add(LoadReport()),
      child: BlocBuilder<ReportBloc, ReportState>(
        bloc: context.read<ReportBloc>(),
        builder: (context, state) {
          if (state is ReportLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReportLoaded) {
            final data = state.report;
            final jumlah = data.fold(0, (sum, report) => sum + report.co2);
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Report',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                      ),
                      UnconstrainedBox(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularStepProgressIndicator(
                            totalSteps: 100,
                            currentStep: jumlah,
                            stepSize: 10,
                            selectedColor: Colors.green,
                            unselectedColor: Colors.grey[200],
                            padding: 0,
                            width: 30,
                            height: 30,
                            selectedStepSize: 10,
                            roundedCap: (_, __) => true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$jumlah%',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'CO2',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Hari ini kamu menghasilkan $jumlah% emisi karbon dari bermain sosial media.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      child: Text(
                        'Data history',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
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
                              imageUrl:
                                  'https://i.pinimg.com/236x/10/6a/a4/106aa400467ac3f9f748481911e3ebdd.jpg',
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[index].title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${data[index].co2} co2'),
                            ],
                          ),
                          subtitle: Text(data[index].description),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Hapus data'),
                                    content: const Text(
                                        'Yakin ingin menghapus data ini?'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<ReportBloc>().add(
                                              DeleteReport(
                                                  token:
                                                      state.report[index].id));
                                          context
                                              .read<ReportBloc>()
                                              .add(LoadReport());
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("Data berhasil dihapus"),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: primaryColor,
                                        ),
                                        child: const Text("Ya"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Tutup dialog
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: grey,
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Text("Tidak"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          } else if (state is ReportError) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    ));
  }
}
