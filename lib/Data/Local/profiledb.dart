import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Profiledb extends HiveObject {
  sevebox() async {
    var box = await Hive.openBox('mybox');
  }

  @HiveField(0)
  late String? name;
}
