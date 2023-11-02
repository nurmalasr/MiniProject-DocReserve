import '../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: ListView(
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
                  totalSteps: 10,
                  currentStep: 1,
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
                      const Text(
                        '1 %',
                        style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Hari ini kamu menghasilkan 10% emisi karbon dari penggunaan listrik.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                    physics: const ClampingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            'https://i.pinimg.com/236x/10/6a/a4/106aa400467ac3f9f748481911e3ebdd.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Menyetrika',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('9,65 CO2'),
                          ],
                        ),
                        subtitle: const Text('Menggunakan listrik'),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
