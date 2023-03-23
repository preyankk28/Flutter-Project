
class Mass {
  Mass({
    this.kg,
    this.lb,
  });

  int? kg;
  int? lb;

  factory Mass.fromJson(Map<String, dynamic> json) => Mass(
    kg: json["kg"],
    lb: json["lb"],
  );

  Map<String, dynamic> toJson() => {
    "kg": kg,
    "lb": lb,
  };
}