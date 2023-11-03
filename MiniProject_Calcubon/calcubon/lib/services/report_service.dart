import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/report.dart';

class ReportService {
  Future<List<Report>> getReportFirebase({required String token}) async {
    final reportSnapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('userId', isEqualTo: token)
        .get();
    return reportSnapshot.docs
        .map(
          (e) => Report(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            co2: e['co2'],
            userId: e['userId'],
            image: e['image'],
          ),
        )
        .toList();
  }

  void createReport({
    required String title,
    required String description,
    required int co2,
    required String userId,
    required String image,
  }) {
    final docReport = FirebaseFirestore.instance.collection('report').doc();
    docReport.set({
      'id': docReport.id,
      'title': title,
      'description': description,
      'co2': co2,
      'userId': userId,
      'image': image,
    });
  }

  void deleteReport({required String token}) {
    FirebaseFirestore.instance.collection('report').doc(token).delete();
  }
}
