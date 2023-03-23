
import 'dart:convert';
import 'Engines.dart';
import 'Mass.dart';

List<Rocket> rocketFromJson(String str) => List<Rocket>.from(json.decode(str).map((x) => Rocket.fromJson(x)));

String rocketToJson(List<Rocket> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rocket {
  Rocket({
    this.id,
    this.country,
    this.company,
    this.mass,
    this.engines,
    this.flickrImages,
    this.wikipedia,
    this.description,
    this.rocketId,
    this.rocketName,
    this.rocketType,
  });

  int? id;
  String? country;
  String? company;
  Mass? mass;
  Engines? engines;
  String? wikipedia;
  String? description;
  String? rocketId;
  String? rocketName;
  String? rocketType;
  List<String>? flickrImages;

  factory Rocket.fromJson(Map<String, dynamic> json) => Rocket(
    id: json["id"],
    country: json["country"],
    company: json["company"],
    mass: json["mass"] == null ? null : Mass.fromJson(json["mass"]),
    engines: json["engines"] == null ? null : Engines.fromJson(json["engines"]),
    flickrImages: json["flickr_images"] == null ? [] : List<String>.from(json["flickr_images"]!.map((x) => x)),
    wikipedia: json["wikipedia"],
    description: json["description"],
    rocketId: json["rocket_id"],
    rocketName: json["rocket_name"],
    rocketType: json["rocket_type"],
  );

  factory Rocket.fromDatabase(Map<String, dynamic> json) => Rocket(
    id: json["id"],
    country: json["country"],
    company: json["company"],
    wikipedia: json["wikipedia"],
    description: json["description"],
    rocketId: json["rocket_id"],
    rocketName: json["rocket_name"],
    rocketType: json["rocket_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "company": company,
    "mass": mass?.toJson(),
    "engines": engines?.toJson(),
    "flickr_images": flickrImages == null ? [] : List<String>.from(flickrImages!.map((x) => x)),
    "wikipedia": wikipedia,
    "description": description,
    "rocket_id": rocketId,
    "rocket_name": rocketName,
    "rocket_type": rocketType,
  };
}






