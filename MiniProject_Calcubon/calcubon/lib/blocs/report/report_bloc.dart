import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/report.dart';
import '../../services/report_service.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportService reportService;
  ReportBloc({required this.reportService}) : super(ReportInitial()) {
    on<LoadReport>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      emit(ReportLoading());
      try {
        final result = await reportService.getReportFirebase(token: token!);
        emit(ReportLoaded(result));
      } catch (e) {
        emit(ReportError(e.toString()));
      }
    });

    on<CreateReport>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      ReportService().createReport(
        title: event.title,
        description: event.description,
        co2: event.co2,
        userId: token!,
        image: event.image,
      );
    });

    on<DeleteReport>((event, emit) {
      ReportService().deleteReport(token: event.token);
    });
  }
}
