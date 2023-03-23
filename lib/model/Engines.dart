
class Engines {
  Engines({
    this.number,
    this.type,
    this.version,
    this.layout,
    this.engineLossMax,
    this.propellant1,
    this.propellant2
  });

  int? number;
  String? type;
  String? version;
  String? layout;
  int? engineLossMax;
  String? propellant1;
  String? propellant2;

  factory Engines.fromJson(Map<String, dynamic> json) => Engines(
    number: json["number"],
    type: json["type"],
    version: json["version"],
    layout: json["layout"],
    engineLossMax: json["engine_loss_max"],
    propellant1: json["propellant_1"],
    propellant2: json["propellant_2"]
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "type": type,
    "version": version,
    "layout": layout,
    "engine_loss_max": engineLossMax,
    "propellant_1": propellant1,
    "propellant_2": propellant2
  };
}
