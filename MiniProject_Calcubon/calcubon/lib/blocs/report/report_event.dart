part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class LoadReport extends ReportEvent {}

final class CreateReport extends ReportEvent {
  final String title;
  final String description;
  final int co2;
  final String image;

  CreateReport({
    required this.title,
    required this.description,
    required this.co2,
    required this.image,
  });
}

final class DeleteReport extends ReportEvent {
  final String token;
  DeleteReport({required this.token});
}
