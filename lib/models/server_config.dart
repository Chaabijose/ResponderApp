class ServerConfig {
  String? id;
  String? name;
  String? code;
  String? type;
  String? contactEmail;
  String? contactPhone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? timeZone;
  String? language;
  String? logoUrl;
  String? primaryColor;
  String? secondaryColor;
  bool? isActive;
  String? settings;
  String? createdAt;
  String? updatedAt;
  int? apiCredentialsCount;
  int? userMappingsCount;

  ServerConfig(
      {this.id,
        this.name,
        this.code,
        this.type,
        this.contactEmail,
        this.contactPhone,
        this.address,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.timeZone,
        this.language,
        this.logoUrl,
        this.primaryColor,
        this.secondaryColor,
        this.isActive,
        this.settings,
        this.createdAt,
        this.updatedAt,
        this.apiCredentialsCount,
        this.userMappingsCount});

  ServerConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    contactEmail = json['contactEmail'];
    contactPhone = json['contactPhone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postalCode'];
    timeZone = json['timeZone'];
    language = json['language'];
    logoUrl = json['logoUrl'];
    primaryColor = json['primaryColor'];
    secondaryColor = json['secondaryColor'];
    isActive = json['isActive'];
    settings = json['settings'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    apiCredentialsCount = json['apiCredentialsCount'];
    userMappingsCount = json['userMappingsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    data['contactEmail'] = contactEmail;
    data['contactPhone'] = contactPhone;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['postalCode'] = postalCode;
    data['timeZone'] = timeZone;
    data['language'] = language;
    data['logoUrl'] = logoUrl;
    data['primaryColor'] = primaryColor;
    data['secondaryColor'] = secondaryColor;
    data['isActive'] = isActive;
    data['settings'] = settings;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['apiCredentialsCount'] = apiCredentialsCount;
    data['userMappingsCount'] = userMappingsCount;
    return data;
  }
}

