class Stasiun {
  final String? code;
  final String? name;
  final String? city;
  final String? cityname;

  Stasiun({
    this.code,
    this.name,
    this.city,
    this.cityname,
  });

  Stasiun.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        name = json['name'] as String?,
        city = json['city'] as String?,
        cityname = json['cityname'] as String?;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'name' : name,
    'city' : city,
    'cityname' : cityname
  };
}