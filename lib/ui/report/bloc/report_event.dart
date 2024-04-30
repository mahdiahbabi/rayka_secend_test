part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class ReportScreenStarted extends ReportEvent {}

final class SearchReport extends ReportEvent {
  final String startTime;
  final String endTime;

  SearchReport({required this.startTime, required this.endTime});
}
