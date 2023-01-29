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
      this.as, 
      this.query,});

  FlagModel.fromJson(dynamic json) {
    status = json['status'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionName = json['regionName'];
    city = json['city'];
    zip = json['zip'];
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    isp = json['isp'];
    org = json['org'];
    as = json['as'];
    query = json['query'];
  }
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
  String? as;
  String? query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['country'] = country;
    map['countryCode'] = countryCode;
    map['region'] = region;
    map['regionName'] = regionName;
    map['city'] = city;
    map['zip'] = zip;
    map['lat'] = lat;
    map['lon'] = lon;
    map['timezone'] = timezone;
    map['isp'] = isp;
    map['org'] = org;
    map['as'] = as;
    map['query'] = query;
    return map;
  }

}