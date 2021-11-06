import 'package:json_annotation/json_annotation.dart';

import '../models/todo.dart';

part 'todos_response.g.dart';

@JsonSerializable()
class TodosResponse {
  TodosResponse(this.todos);

  Map<String, dynamic> toJson() => _$TodosResponseToJson(this);

  final List<Todo> todos;
}