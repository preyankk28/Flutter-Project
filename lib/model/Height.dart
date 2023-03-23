class Height {
  Height({
      this.meters, 
      this.feet,});

  Height.fromJson(dynamic json) {
    meters = json['meters'];
    feet = json['feet'];
  }
  double? meters;
  double? feet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meters'] = meters;
    map['feet'] = feet;
    return map;
  }

}