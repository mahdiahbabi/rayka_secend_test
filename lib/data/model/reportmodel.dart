
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
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['count'] = this.count;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.trip != null) {
      data['trip'] = this.trip!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['total_distance'] = this.totalDistance;
    data['total_actual_distance'] = this.totalActualDistance;
    data['total_duration'] = this.totalDuration;
    data['total_actual_duration'] = this.totalActualDuration;
    return data;
  }
}
