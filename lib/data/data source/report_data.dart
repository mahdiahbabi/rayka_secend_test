import 'package:dio/dio.dart';
import 'package:rayka_secend_test/data/model/reportmodel.dart';
import 'package:rayka_secend_test/data/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IReportDataSource {
  Future<UserModel> getUserInfo(
    String username,
    String password,
  );
  Future<ReportInfo> getReport(
      String startTime, String endTime, String accessToken);
}

class RemotReportDataSource implements IReportDataSource {
  final Dio dio;

  RemotReportDataSource(this.dio);
  @override
  Future<ReportInfo> getReport(
      String startTime, String endTime, String accessToken) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    var response = await dio.get(
        '/api/v1/app/drivers-trips-reports/?status=&start_time_after=$startTime&start_time_before=&end_time_after=$endTime&end_time_before=&selected_time_after=&selected_time_before=&created_at_after=&created_at_before=');
    var resualt = ReportInfo.fromJson(response.data);
    return resualt;
  }

  @override
  Future<UserModel> getUserInfo(String username, String password) async {
    var response = await dio.post('/api/v1/app/login/', data: {
      'username': username,
      'password': password,
    });
    var resualt = UserModel.fromJson(response.data);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", resualt.result!.accessToken!);
    return resualt;
  }
}
