//-- class name and parameters changes according to your needs this is demo responses class model

class LocationInfo {
  final String? location_Des;
  final String? locationName;



  LocationInfo(this.location_Des, this.locationName);

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_new
    return new LocationInfo(
        json["locationName"], json["guardName"]);
  }
  Map<String, dynamic> toJson() => {
        "locationDes":location_Des,
        "locationName": locationName,

      };
  Map<String, dynamic> toMap() {
    return {
      'locationDes':location_Des,
      'locationName': locationName,
    };
  }
}
