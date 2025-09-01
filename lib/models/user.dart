import 'helper/title_model.dart';

class User  extends TitleModel {
  int? employeeId;
  String? alphaNumericEmployeeId;
  String? firstName;
  String? lastName;
  String? middleInitial;
  String? userName;
  String? email;
  bool? isActive;
  String? mobilePhone;
  String? homePhone;
  String? employeeAddress;
  String? city;
  String? state;
  String? agencyId;
  num? stationId;
  num? unitId;
  int? defaultUserGroup;
  String? activeDirectoryLink;
  String? domain;

  User(
      {this.employeeId,
        this.alphaNumericEmployeeId,
        this.firstName,
        this.lastName,
        this.middleInitial,
        this.userName,
        this.email,
        this.isActive,
        this.mobilePhone,
        this.homePhone,
        this.employeeAddress,
        this.city,
        this.state,
        this.agencyId,
        this.stationId,
        this.unitId,
        this.defaultUserGroup,
        this.activeDirectoryLink,
        this.domain});

  User.fromMap(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    alphaNumericEmployeeId = json['alphaNumericEmployeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleInitial = json['middleInitial'];
    userName = json['userName'];
    email = json['email'];
    isActive = json['isActive'];
    mobilePhone = json['mobilePhone'];
    homePhone = json['homePhone'];
    employeeAddress = json['employeeAddress'];
    city = json['city'];
    state = json['state'];
    agencyId = json['agencyId'];
    stationId = json['stationId'];
    unitId = json['unitId'];
    defaultUserGroup = json['defaultUserGroup'];
    activeDirectoryLink = json['activeDirectoryLink'];
    domain = json['domain'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['alphaNumericEmployeeId'] = this.alphaNumericEmployeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleInitial'] = this.middleInitial;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['mobilePhone'] = this.mobilePhone;
    data['homePhone'] = this.homePhone;
    data['employeeAddress'] = this.employeeAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['agencyId'] = this.agencyId;
    data['stationId'] = this.stationId;
    data['unitId'] = this.unitId;
    data['defaultUserGroup'] = this.defaultUserGroup;
    data['activeDirectoryLink'] = this.activeDirectoryLink;
    data['domain'] = this.domain;
    return data;
  }

  @override
  String get title => firstName??'-----';

}

