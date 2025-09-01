class ServerHealth {
  String? status;
  String? timestamp;
  String? version;
  String? environment;
  String? uptime;
  Services? services;

  ServerHealth(
      {this.status,
        this.timestamp,
        this.version,
        this.environment,
        this.uptime,
        this.services});

  ServerHealth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    timestamp = json['timestamp'];
    version = json['version'];
    environment = json['environment'];
    uptime = json['uptime'];
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    data['version'] = this.version;
    data['environment'] = this.environment;
    data['uptime'] = this.uptime;
    if (this.services != null) {
      data['services'] = this.services!.toJson();
    }
    return data;
  }
}

class Services {
  String? aPI;
  String? database;
  String? cache;
  String? messaging;

  Services({this.aPI, this.database, this.cache, this.messaging});

  Services.fromJson(Map<String, dynamic> json) {
    aPI = json['API'];
    database = json['Database'];
    cache = json['Cache'];
    messaging = json['Messaging'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['API'] = this.aPI;
    data['Database'] = this.database;
    data['Cache'] = this.cache;
    data['Messaging'] = this.messaging;
    return data;
  }
}