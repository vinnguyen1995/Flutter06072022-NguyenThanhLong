class UserDto {
  UserDto({
    this.email,
    this.name,
    this.phone,
    this.userGroup,
    this.registerDate,
    this.token,
  });

  UserDto.fromJson(dynamic json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    userGroup = json['userGroup'];
    registerDate = json['registerDate'];
    token = json['token'];
  }

  String? email;
  String? name;
  String? phone;
  int? userGroup;
  String? registerDate;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['name'] = name;
    map['phone'] = phone;
    map['userGroup'] = userGroup;
    map['registerDate'] = registerDate;
    map['token'] = token;
    return map;
  }

  static UserDto convertJson(dynamic json) => UserDto.fromJson(json);
}
