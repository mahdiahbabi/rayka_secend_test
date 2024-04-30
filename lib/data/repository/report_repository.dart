import 'package:rayka_secend_test/common/httpclient.dart';
import 'package:rayka_secend_test/data/data%20source/report_data.dart';
import 'package:rayka_secend_test/data/model/reportmodel.dart';
import 'package:rayka_secend_test/data/model/usermodel.dart';

var reposrtRepository =
    ReportRepository(dataSource: RemotReportDataSource(httpClient));

abstract class IReportRepository {
  Future<UserModel> getUserInfo(String username, String password);
  Future<ReportInfo> getReport(
      String startTime, String endTime, String accessToken);
}

class ReportRepository implements IReportRepository {
  final RemotReportDataSource dataSource;

  ReportRepository({required this.dataSource});
  @override
  Future<ReportInfo> getReport(
      String startTime, String endTime, String accessToken) {
    return dataSource.getReport(startTime, endTime, accessToken);
  }

  @override
  Future<UserModel> getUserInfo(String username, String password) {
    return dataSource.getUserInfo(username, password);
  }
}
