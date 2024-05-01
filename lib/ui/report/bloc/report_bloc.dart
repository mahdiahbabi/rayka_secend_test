import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:rayka_secend_test/common/exception.dart';
import 'package:rayka_secend_test/data/model/reportmodel.dart';
import 'package:rayka_secend_test/data/repository/report_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<ReportEvent>((event, emit) async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      try {
        if (event is SearchReport) {
          emit(ReportScreenLoading());
          var accessToken = sharedPreferences.getString("access_token");
          if (accessToken == null) {
            await reposrtRepository.getUserInfo('0915', 's@12e456');
          }

          var tripReport = await reposrtRepository.getReport(
              event.startTime, event.endTime, accessToken ?? '');
          emit(ReposrtScreenSuccess(report: tripReport));
        }
      } catch (e) {
        var connectivityResult = await Connectivity().checkConnectivity();

        if (connectivityResult == ConnectivityResult.none) {
          emit(ReportScreenEror(
              appException: AppException(
                  message:
                      'لطفا اتصال اینترنت را بررسی کنید و مجدد تلاش کنید ')));
        } else {
          emit(ReportScreenEror(
              appException: AppException(message: e.toString())));
        }
      }
    });
  }
}
