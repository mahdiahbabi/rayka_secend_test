class UserModel {
  String? type;
  Null? count;
  Null? message;
  Result? result;

  UserModel({this.type, this.count, this.message, this.result});

  UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    count = json['count'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['count'] = this.count;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? name;
  Null? thumbnailAvatar;
  String? lastLogin;
  Role? role;
  String? accessToken;
  String? refreshToken;

  Result(
      {this.name,
      this.thumbnailAvatar,
      this.lastLogin,
      this.role,
      this.accessToken,
      this.refreshToken});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnailAvatar = json['thumbnail_avatar'];
    lastLogin = json['last_login'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['thumbnail_avatar'] = this.thumbnailAvatar;
    data['last_login'] = this.lastLogin;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}

class Role {
  int? number;
  String? name;

  Role({this.number, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    return data;
  }
}
