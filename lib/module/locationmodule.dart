import 'package:flutter/foundation.dart';

class Locations {
  final String locationId;
  final String location_name;

  Locations({required this.locationId, required this.location_name});
  factory Locations.fromJson(Map<String, dynamic> json) =>
      Locations(locationId: json['id'], location_name: json['location_name']);

  Map<String, dynamic> toJson() =>
      {'id': locationId, 'location_name': location_name};
}
