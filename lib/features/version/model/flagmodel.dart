import 'dart:convert';

FlagModel flagModelFromJson(String str) => FlagModel.fromJson(json.decode(str));

String flagModelToJson(FlagModel data) => json.encode(data.toJson());

class FlagModel {
  FlagModel({
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.flagModelAs,
    this.query,
  });

  String? status;
  String? country;
  String? countryCode;
  String? region;
  String? regionName;
  String? city;
  String? zip;
  double? lat;
  double? lon;
  String? timezone;
  String? isp;
  String? org;
  String? flagModelAs;
  String? query;

  factory FlagModel.fromJson(Map<String, dynamic> json) => FlagModel(
    status: json["status"],
    country: json["country"],
    countryCode: json["countryCode"],
    region: json["region"],
    regionName: json["regionName"],
    city: json["city"],
    zip: json["zip"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    timezone: json["timezone"],
    isp: json["isp"],
    org: json["org"],
    flagModelAs: json["as"],
    query: json["query"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "country": country,
    "countryCode": countryCode,
    "region": region,
    "regionName": regionName,
    "city": city,
    "zip": zip,
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "isp": isp,
    "org": org,
    "as": flagModelAs,
    "query": query,
  };
}
