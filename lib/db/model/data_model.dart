import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class messagemodel {
  @HiveField(0)
  int? id;
  @HiveField(0)
  final String message;
  @HiveField(1)
  final String hint;
  messagemodel({required this.message, required this.hint, this.id});
}
