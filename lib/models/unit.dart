import 'package:responder_app/models/helper/title_model.dart';

class Unit extends TitleModel{
  String? unitId;
  String? beat;
  String? agencyId;
  String? bay;
  String? unitType;
  String? station;
  int? latitude;
  int? longitude;
  String? dispatchGroup;
  int? defaultStatus;
  String? location;
  int? logonStatus;
  String? extendedUnitAttributes;
  bool? isLateRun;
  bool? isSharedCrew;
  String? symbolNumber;
  String? externalCalendarUserName;
  String? externalCalendarUserId;
  String? externalCalendarName;
  String? externalCalendarId;
  DateTime? lastLogin;

  Unit(
      {this.unitId,
        this.beat,
        this.agencyId,
        this.bay,
        this.unitType,
        this.station,
        this.latitude,
        this.longitude,
        this.dispatchGroup,
        this.defaultStatus,
        this.location,
        this.logonStatus,
        this.extendedUnitAttributes,
        this.isLateRun,
        this.isSharedCrew,
        this.symbolNumber,
        this.externalCalendarUserName,
        this.externalCalendarUserId,
        this.externalCalendarName,
        this.externalCalendarId,
        this.lastLogin,
      });

  Unit.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    beat = json['beat'];
    agencyId = json['agencyId'];
    bay = json['bay'];
    unitType = json['unitType'];
    station = json['station'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    dispatchGroup = json['dispatchGroup'];
    defaultStatus = json['defaultStatus'];
    location = json['location'];
    logonStatus = json['logonStatus'];
    extendedUnitAttributes = json['extendedUnitAttributes'];
    isLateRun = json['isLateRun'];
    isSharedCrew = json['isSharedCrew'];
    symbolNumber = json['symbolNumber'];
    externalCalendarUserName = json['externalCalendarUserName'];
    externalCalendarUserId = json['externalCalendarUserId'];
    externalCalendarName = json['externalCalendarName'];
    externalCalendarId = json['externalCalendarId'];
    lastLogin = DateTime.tryParse(json['lastLogin']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitId'] = unitId;
    data['beat'] = beat;
    data['agencyId'] = agencyId;
    data['bay'] = bay;
    data['unitType'] = unitType;
    data['station'] = station;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['dispatchGroup'] = dispatchGroup;
    data['defaultStatus'] = defaultStatus;
    data['location'] = location;
    data['logonStatus'] = logonStatus;
    data['extendedUnitAttributes'] = extendedUnitAttributes;
    data['isLateRun'] = isLateRun;
    data['isSharedCrew'] = isSharedCrew;
    data['symbolNumber'] = symbolNumber;
    data['externalCalendarUserName'] = externalCalendarUserName;
    data['externalCalendarUserId'] = externalCalendarUserId;
    data['externalCalendarName'] = externalCalendarName;
    data['externalCalendarId'] = externalCalendarId;
    data['lastLogin'] = lastLogin?.toIso8601String();
    return data;
  }

  @override
  String get title => '$agencyId - $unitId';
}