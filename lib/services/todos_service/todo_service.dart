import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/todo.dart';
import '../../responses/todos_response.dart';

part 'todo_service.g.dart';

class TodoService {
  final List<Todo> _todos = [
    Todo(id: '1', name: 'Todo 1'),
    Todo(id: '2', name: 'Todo 2'),
  ];

  Router get router => _$TodoServiceRouter(this);

  @Route.get('/')
  Future<Response> getTodos(Request request) async {
    if (_todos.isEmpty) {
      return Response(HttpStatus.noContent);
    }
    final todosResponse = TodosResponse(_todos);
    return Response(HttpStatus.ok, body: jsonEncode(todosResponse));
  }

  @Route.get('/<id>')
  Future<Response> getTodoById(Request request, String id) async {
    if (_todos.any((todo) => todo.id == id)) {
      final todo = _todos.singleWhere((todo) => todo.id == id);
      return Response(HttpStatus.ok, body: jsonEncode(todo));
    }
    return Response(HttpStatus.badRequest, body: jsonEncode({'error': 'There are no such an object'}));
  }

  @Route.post('/')
  Future<Response> postTodo(Request request) async {
    try {
      final jsonTodo = jsonDecode(await request.readAsString());
      final todo = Todo.fromJson(jsonTodo);
      if (_todos.any((td) => td.id == todo.id)) {
        return Response(HttpStatus.badRequest, body: jsonEncode({'error': 'Such an object already created'}));
      }
      _todos.add(todo);
      return Response(HttpStatus.created);
    } on Exception catch(e) {
      return Response(HttpStatus.badRequest, body: jsonEncode({'error': e.toString()}));
    }
  }

  @Route.put('/<id>')
  Future<Response> putTodo(Request request) async {
    try {
      final jsonTodo = jsonDecode(await request.readAsString());
      final todo = Todo.fromJson(jsonTodo);
      if (_todos.any((td) => td.id == todo.id)) {
        _todos.replaceRange(
          int.parse(todo.id) - 1, 
          int.parse(todo.id), 
          [todo]
        );
        return Response(HttpStatus.ok, body: jsonEncode({'editedTodo': todo}));
      }
      return Response(HttpStatus.badRequest, body: jsonEncode({'error': 'There are no element with such id'}));
    } on Exception catch(e) {
      return Response(HttpStatus.badRequest, body: jsonEncode({'error': e.toString()}));
    }
  }
  
}