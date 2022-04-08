import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable(explicitToJson: true)
class TodoItem {
  final String id;
  String text;

  TodoItem({required this.id, required this.text});

  factory TodoItem.fromJson(Map<String, dynamic> json) => _$TodoItemFromJson(json);
}
