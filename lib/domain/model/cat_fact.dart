import 'package:hive/hive.dart';
part 'cat_fact.g.dart';

@HiveType(typeId: 0)
class CatFact extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final DateTime createdAt;

  CatFact({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory CatFact.fromJson(Map<String, dynamic> json) {
    return CatFact(
      id: json['_id'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
