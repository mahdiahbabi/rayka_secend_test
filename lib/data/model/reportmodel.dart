class ReportInfo {
  String? type;
  Null? count;
  Null? message;
  List<Result>? result;

  ReportInfo({this.type, this.count, this.message, this.result});

  ReportInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    count = json['count'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }
}

class Result {
  Driver? driver;
  Trip? trip;

  Result({this.driver, this.trip});

  Result.fromJson(Map<String, dynamic> json) {
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    trip = json['trip'] != null ? new Trip.fromJson(json['trip']) : null;
  }
}

class Driver {
  int? id;
  String? firstName;
  String? lastName;

  Driver({this.id, this.firstName, this.lastName});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
}

class Trip {
  int? totalCount;
  double? totalDistance;
  double? totalActualDistance;
  double? totalDuration;
  double? totalActualDuration;

  Trip(
      {this.totalCount,
      this.totalDistance,
      this.totalActualDistance,
      this.totalDuration,
      this.totalActualDuration});

  Trip.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    totalDistance = json['total_distance'];
    totalActualDistance = json['total_actual_distance'];
    totalDuration = json['total_duration'];
    totalActualDuration = json['total_actual_duration'];
  }
}
