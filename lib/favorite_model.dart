import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  late String code;

  @HiveField(1)
  late bool isFavorite;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late String cityname;

  FavoriteModel({
    required this.code,
    required this.isFavorite,
    required this.name,
    required this.cityname,
  });
}
