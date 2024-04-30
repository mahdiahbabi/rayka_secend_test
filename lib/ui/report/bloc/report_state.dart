part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReposrtScreenSuccess extends ReportState {
  final ReportInfo report;

  ReposrtScreenSuccess({required this.report});
}

final class ReportScreenEror extends ReportState {
  final AppException appException;

  ReportScreenEror({required this.appException});
}

final class ReportScreenLoading extends ReportState {}
